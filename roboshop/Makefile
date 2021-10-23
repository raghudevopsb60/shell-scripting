help:
	@IFS=$$'\n' ; \
        help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
        for help_line in $${help_lines[@]}; do \
            IFS=$$'#' ; \
            help_split=($$help_line) ; \
            help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            printf "%-15s %s\n" $$help_command $$help_info ; \
        done

git-pull:
	@echo -------+ Pulling Git Code +--------
	@git pull &>/dev/null

cart: git-pull ## Setup Cart Component
	@sudo bash components/cart.sh

catalogue: git-pull ## Setup Catalogue Component
	@sudo bash components/catalogue.sh

user: git-pull ## Setup User Component
	@sudo bash components/user.sh

shipping: git-pull ## Setup Shipping Component
	@sudo bash components/shipping.sh

payment: git-pull ## Setup Payment Component
	@sudo bash components/payment.sh

frontend: git-pull ## Setup Frontend Component
	@sudo bash components/frontend.sh

mysql: git-pull ## Setup MySQL Component
	@sudo bash components/mysql.sh

redis: git-pull ## Setup Redis Component
	@sudo bash components/redis.sh

rabbitmq: git-pull ## Setup RabbitMQ Component
	@sudo bash components/rabbitmq.sh

mongodb: git-pull ## Setup MongoDB Component
	@sudo bash components/mongodb.sh
