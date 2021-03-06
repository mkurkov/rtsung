class RTsung
  class Option
    TYPE = :ts_http

    USER_AGENT_PROBABILITY = 100

    def initialize(name, options = {}, &block)
      @attrs = {
        :name => name,
        :type => options[:type] || TYPE
      }

      @user_agents = []

      instance_eval(&block) if block_given?
    end

    def user_agent(name, options = {})
      @user_agents << {
        :name => name,
        :probability => options[:probability] || USER_AGENT_PROBABILITY
      }
    end

    def name(name, options = {})
      user_agent(name, options)
    end

    def to_xml(xml)
      if @user_agents.empty?
        xml.option @attrs
      else
        xml.option(@attrs) do
          @user_agents.each { |u|
            xml.user_agent({ :probability => u[:probability] }) do
              xml.text! u[:name]
            end
          }
        end
      end
    end

  end
end
