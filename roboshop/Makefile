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
	@git pull &>/dev/null

cart: git-pull ## Setup Cart Component
	@bash components/cart.sh

catalogue: git-pull ## Setup Catalogue Component
	@bash components/catalogue.sh

user: git-pull ## Setup User Component
	@bash components/user.sh

shipping: git-pull ## Setup Shipping Component
	@bash components/shipping.sh

payment: git-pull ## Setup Payment Component
	@bash components/payment.sh

frontend: git-pull ## Setup Frontend Component
	@bash components/frontend.sh

mysql: git-pull ## Setup MySQL Component
	@bash components/mysql.sh

redis: git-pull ## Setup Redis Component
	@bash components/redis.sh

rabbitmq: git-pull ## Setup RabbitMQ Component
	@bash components/rabbitmq.sh

mongodb: git-pull ## Setup MongoDB Component
	@bash components/mongodb.sh
