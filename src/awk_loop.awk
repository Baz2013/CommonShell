BEGIN{
	###for loop
	printf("for loop: \n")

	for(i = 1;i < 10;i++)
	{
		printf("%03d ",i);
	}
	printf("\n");

	###while
	printf("while loop: \n")
	i=10
	while(i < 20 )
	{
		printf("%03d ",i);
		i++;
	}
	printf("\n");

	###for in loop
	printf("for in loop\n");

	printf("printf environment variable \n");

	for(key in ENVIRON)
	{
		print "ENVIRON["key"]="ENVIRON[key];
	}

	###do while loop
	printf("do ... while loop\n");

	i=20
	do{
		printf("%03d ",i);
		i++;
	}while(i < 30)
	printf("\n");

}

