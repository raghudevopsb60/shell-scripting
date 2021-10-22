help:
	@IFS=$$'\n' ; \
        help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
        for help_line in $${help_lines[@]}; do \
            IFS=$$'#' ; \
            help_split=($$help_line) ; \
            help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            printf "%-10s %s\n" $$help_command $$help_info ; \
        done

cart: ## Setup Cart Component
	@bash components/cart.sh

catalogue: ## Setup Catalogue Component
	@bash components/catalogue.sh

user: ## Setup User Component
	@bash components/user.sh

shipping: ## Setup Shipping Component
	@bash components/shipping.sh

payment: ## Setup Payment Component
	@bash components/payment.sh

frontend: ## Setup Frontend Component
	@bash components/frontend.sh

mysql: ## Setup MySQL Component
	@bash components/mysql.sh

redis: ## Setup Redis Component
	@bash components/redis.sh

rabbitmq: ## Setup RabbitMQ Component
	@bash components/rabbitmq.sh

mongodb: ## Setup MongoDB Component
	@bash components/mongodb.sh
