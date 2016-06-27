
#include <Block.hpp>
#include <BlockFactory.hpp>
#include <arpa/inet.h>
#include <Packet.hpp>

using namespace pugi;

namespace blockmon
{

    class Filter: public Block
    {
    protected:
        static const int FIELD_ACTIVE = 1;
        static const int FILTER_OUT = 2;

        int m_in_gate;
        int m_out_gate;

        uint32_t m_ip_src_address;
        uint32_t m_ip_src_mask;
        uint8_t m_ip_src_mode;

        uint32_t m_ip_dst_address;
        uint32_t m_ip_dst_mask;
        uint8_t m_ip_dst_mode;

        uint16_t m_layer4_proto;
        uint8_t m_layer4_mode;

        uint8_t m_src_port_mode;
        uint8_t m_dst_port_mode;

    public:
        Filter(const std::string &name, invocation_type invocation) :
            Block(name, invocation),
            m_in_gate(register_input_gate("in_pkt")),
            m_out_gate(register_output_gate("out_pkt")),
            m_ip_src_address(0),
            m_ip_src_mask(0),
            m_ip_src_mode(0),
            m_ip_dst_address(0),
            m_ip_dst_mask(0),
            m_ip_dst_mode(0),
            m_layer4_proto(0),
            m_layer4_mode(0),
            m_src_port_mode(0),
            m_dst_port_mode(0)
        {}

        virtual ~Filter()
        {}

        /* make this class abstract */
        virtual void _receive_msg(std::shared_ptr<const Msg>&& m, int ) = 0;

        /**
          * decides whether filtering should go on or the packet should be discarded
          * @param filter_result whether the filter matched for a given field
          * @param filter_mode the filter mode byte associated to that field
          * @return false if the packet should be discarded, true otherwise
          */
        static inline bool go_ahead(bool filter_result, uint8_t filter_mode)
        {
            return (((filter_mode & (1<<FILTER_OUT)) && (!filter_result)) ||
                    ((!(filter_mode & (1<<FILTER_OUT))) && filter_result)) ;
        }

        /**
          * helper function, convert a string representing an ip address to its binary version (in host by order)
          * @param str_ip the strin representing the address
          * @return the binary ip address (in host byte order)
          */
        static uint32_t string_to_ip(const char* str_ip)
        {
            uint32_t ret_val;
            if(inet_pton(AF_INET, str_ip, &ret_val) != 1)
                throw std::runtime_error("PacketFilter : cannot parse ip address");
            return ntohl(ret_val);
        }

        /**
          * helper function, tells whether a given field should be considered for filtering
          * @param filter_mode the filter mode byte for that field
          * @return true if field has to be checked, false otherwise
          */
        static inline bool is_indirect(uint8_t filter_mode)
        {
            return (filter_mode & (1<<FIELD_ACTIVE));
        }

        /**
          * helper function, sends the packet out of the out gage
          * @param m the packet to be forwarded
          */
        inline void packet_passed(std::shared_ptr<const Msg>&& m)
        {
            send_out_through(std::move(m),m_out_gate);
        }

        /**
          * helper function: throws an exception with a string specifying the name
          * of the wrong xml elem. This is used to signal malformed xml
          * @param the xml field which is not well formed
          */
        static inline void signal_error(const std::string& fieldname)
        {
            std::string  errstr ("PacketFilter:: malformed xml node for the field ");
            errstr+=fieldname;
            throw std::runtime_error(errstr);
        }

        /**
          * parses the filte_mode xlm and sets the filter mdoe byte accordingly
          * @param field_node the filter_mode xml subtree
          * @param mode_byte the filter mode byte to be set
          */
        static inline bool parse_filter_mode(xml_node& field_node, uint8_t& mode_byte)
        {
            xml_node mode;
            if(!(mode = field_node.child("filter_mode")))
                return false;
            mode_byte |= 1<<FIELD_ACTIVE;
            if(xml_attribute behavior = mode.attribute("behavior"))
            {
                if(!(strcmp(behavior.value(),"discard")))
                    mode_byte |= 1<<FILTER_OUT;
                else if (strcmp(behavior.value(),"accept"))
                    return false;
            }
            else
                return false;

            return true;
        }

         /**
           * configures the filter
           * @param n the xml subtree
           */
        virtual void _configure(const xml_node&  n )
        {
            if(xml_node c = n.child("ip_src"))
            {
                if(parse_filter_mode(c,m_ip_src_mode))
                {
                    if(xml_attribute attr = c.attribute("address"))
                        m_ip_src_address = string_to_ip(attr.value());
                    else
                        signal_error ("ip_src");

                    if(xml_attribute attr = c.attribute("netmask"))
                        m_ip_src_mask = string_to_ip(attr.value());
                    else
                        signal_error ("ip_src");
                }
                else
                {
                    signal_error("ip_src");
                }
            }

            if(xml_node c = n.child("ip_dst"))
            {
                if(parse_filter_mode(c,m_ip_dst_mode))
                {
                    if(xml_attribute attr = c.attribute("address"))
                        m_ip_dst_address = string_to_ip(attr.value());
                    else
                        signal_error ("ip_dst");

                    if(xml_attribute attr = c.attribute("netmask"))
                        m_ip_dst_mask = string_to_ip(attr.value());
                    else
                        signal_error ("ip_dst");
                }
                else
                {
                    signal_error("ip_dst");
                }
            }

            if(xml_node c = n.child("l4_protocol"))
            {
                if(parse_filter_mode(c,m_layer4_mode))
                {
                    if(xml_attribute attr = c.attribute("number"))
                        m_layer4_proto = attr.as_uint();
                    else
                        signal_error("l4_protocol");
                }
                else
                {
                    signal_error("l4_protocol");
                }
            }
        }
    };
}
