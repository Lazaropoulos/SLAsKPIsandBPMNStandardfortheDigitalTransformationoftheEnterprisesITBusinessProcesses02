clear all;
clc;

tic;

% Counter initialization             % Simulation module      % SLOs / KPIs
    Counter_A_1       =0; Counter_A_2         =0;
    Counter_B_1       =0; Counter_B_2         =0;
    Counter_B1_1      =0; Counter_B2_1        =0;
    Counter_C_1       =0; Counter_C_2         =0;
    Counter_C1_1      =0; Counter_C2_1        =0;
    Counter_D_1       =0; Counter_D_2         =0;

MathematicalOperator_A_1 = 0;

% Start of the simulation process (1,000 simulations)
for Simulation_Counter=(1:1:1000)                    % Simulation module
    SimulationIsActive=1;                               % Simulation module

    % Token initialization                              % Simulation module
        Token_TimerTrigger=1; Token_Activity01  =0; Token_DataObject01  =0;
        Token_Gateway01a  =0; Token_Gateway01b  =0; Token_Activity02a   =0;
        Token_Activity02b =0; Token_Message01   =0; Token_DataObject02  =0;
        Token_Message02   =0; Token_DataObject02=0; Token_Activity04a   =0;
        Token_Activity04b =0; Token_Message03   =0; Token_DataObject03  =0;
        Token_Message04   =0; Token_Activity05a =0; Token_Activity05b   =0;
        Token_Gateway02   =0; Token_Message05   =0; Token_Activity03    =0;
        Token_Message06   =0; Token_Database01a =0; Token_Database01b   =0;
        Token_DataObject04=0; Token_EventEnd    =0;

    % Duration timer initialization                     % Simulation module
        T=0;  % Simulation duration timer
        T_Gateway01a      =0; T_Gateway01b      =0;
        T_Activity02a     =0;
	    T_Activity04a     =0; T_Activity04b     =0;
        T_Activity05a     =0; T_Activity05b     =0;
	    T_Database01a     =0;

    % Gateway counter initialization                    % Simulation module
        Counter_NOT_OK    =0; 

    % SLO A
        % Counter_A_1
        Counter_A_1= Counter_A_1 + 1;
        T_Counter_A_1(Simulation_Counter)=Counter_A_1;

    % SLO B
        % Counter_B_1
        Counter_B_1= Counter_B_1 + 1;
        T_Counter_B_1(Simulation_Counter)=Counter_B_1;

    % Department A
    % TimerTrigger (ID:BE01)
        if ((SimulationIsActive==1)&&(Token_TimerTrigger==1))
            Token_TimerTrigger=0;

            % SLO and KPI attributes
            p_av_TimerTrigger    =1;
            d_mu_TimerTrigger    =0;
            d_sigma2_TimerTrigger=0;
            p_f_TimerTrigger     =0;

            % Check the availability
            flag_operation_TimerTrigger(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_TimerTrigger,...
                p_av_TimerTrigger]));
            SimulationIsActive  = ...
                flag_operation_TimerTrigger(Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_TimerTrigger(Simulation_Counter)=...
                    d_mu_TimerTrigger+(d_sigma2_TimerTrigger*randn);

                % Duration of the BPMN IT
                % business process until now.
                T = T + T_TimerTrigger(Simulation_Counter);

                % The Token passes to the
                % next element;
                Token_Activity01=1;
            else
                flag_fault_TimerTrigger(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_TimerTrigger,...
                    p_f_TimerTrigger]));
            end
        end

    % Activity01 (ID:BE02)
        if ((SimulationIsActive==1)&&(Token_Activity01==1))
            Token_Activity01=0;

        % SLO C
            % Counter_C_1
            Counter_C_1= Counter_C_1 + 1;
            T_Counter_C_1(Simulation_Counter)=Counter_C_1;

            % SLO and KPI attributes
            p_av_Activity01      =0.99;
            d_mu_Activity01      =3;
            d_sigma2_Activity01  =0.50;
            p_f_Activity01       =0.12;

            % Check the availability
            flag_operation_Activity01(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_Activity01,...
                p_av_Activity01]));
            SimulationIsActive  = ...
                flag_operation_Activity01(Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_Activity01(Simulation_Counter)=...
                    d_mu_Activity01+(d_sigma2_Activity01*randn);

                % Duration of the BPMN IT
                % business process until now.
                T_Gateway01a = T + T_Activity01(Simulation_Counter);

                % The Token passes to the
                % next elements;
                Token_Gateway01a=1;                     % Simulation module
                Token_DataObject01=1;

            % SLO C
                % Counter_C_2
                Counter_C_2 = Counter_C_2+1;
                T_Counter_C_2(Counter_C_1)=Counter_C_2;

                % Duration_C_1
                Duration_C_1 = T_Activity01(Simulation_Counter);
                T_Duration_C_1(Counter_C_2) = Duration_C_1;

            % SLO C1
                % Flag_C1_1
                if (Duration_C_1<=3.5)
                    Flag_C1_1=1;
                else
                    Flag_C1_1=0;
                end
                T_Flag_C1_1(Counter_C_2)= Flag_C1_1;

                % Counter_C1_1
                if (Flag_C1_1==1)
                    Counter_C1_1= Counter_C1_1+1;
                end
                T_Counter_C1_1(Counter_C_2)= Counter_C1_1;

                % MathematicalOperator_C1_1
                MathematicalOperator_C1_1=100* Counter_C1_1/Counter_C_2;
                T_MathematicalOperator_C1_1(Counter_C_2)=...
                    MathematicalOperator_C1_1;

                % Flag_C1_2 comes right after the
                % MathematicalOperator_C1_1
                if (MathematicalOperator_C1_1>=85)
                    Flag_C1_2=1;
                else
                    Flag_C1_2=0;
                end
                T_Flag_C1_2(Counter_C_2)=Flag_C1_2;

            % SLO C2
                % Flag_C2_1
                if (Duration_C_1<=7)
                    Flag_C2_1=1;
                else
                    Flag_C2_1=0;
                end
                T_Flag_C2_1(Counter_C_2)= Flag_C2_1;

                % Counter_C2_1
                if (Flag_C2_1==1)
                    Counter_C2_1= Counter_C2_1+1;
                end
                T_Counter_C2_1(Counter_C_2)= Counter_C2_1;

                % MathematicalOperator_C2_1
                MathematicalOperator_C2_1=100* Counter_C2_1/Counter_C_2;
                T_MathematicalOperator_C2_1(Counter_C_2)=...
                    MathematicalOperator_C2_1;

                % Flag_C2_2 comes right after the
                % MathematicalOperator_C2_1
                if (MathematicalOperator_C2_1>=99.95)
                    Flag_C2_2=1;
                else
                    Flag_C2_2=0;
                end
                T_Flag_C2_2(Counter_C_2)=Flag_C2_2;

            else
                flag_fault_Activity01(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_Activity01,...
                    p_f_Activity01]));
            end
        end

    % DataObject01 (ID:BE03)
        if ((SimulationIsActive==1)&&(Token_DataObject01==1))
            Token_DataObject01=0;

            % SLO and KPI attributes
            p_av_DataObject01      =1;
            d_mu_DataObject01      =0;
            d_sigma2_DataObject01  =0;
            p_f_DataObject01       =0;

            % Check the availability
            flag_operation_DataObject01(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_DataObject01,...
                p_av_DataObject01]));
            SimulationIsActive  = ...
                flag_operation_DataObject01(Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_DataObject01(Simulation_Counter)=...
                    d_mu_DataObject01+(d_sigma2_DataObject01*randn);

                % Duration of the BPMN IT
                % business process until now.
                T_Activity02a = T_Gateway01a + ...   % Simulation ...module
                    T_DataObject01(Simulation_Counter);

                % The Token passes to the
                % next element;
                Token_Activity02a=1;                 % Simulation ...module
            else
                flag_fault_DataObject01(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_DataObject01,...
                    p_f_DataObject01]));
            end
        end

        while (((Token_Gateway01a==1)&&...
                        (Token_Gateway01b==0))|...      % Simulation module
                ((Token_Gateway01a==0)&&...
                        (Token_Gateway01b==1)))

            % Gateway01 (ID:BE04)
                if ((SimulationIsActive==1)&&...
                        (((Token_Gateway01a==1)&&...
                        (Token_Gateway01b==0))|...
                        ((Token_Gateway01a==0)&&...
                        (Token_Gateway01b==1))))
                    if (Token_Gateway01a==1)
                        Token_Gateway01a=0;
                    else
                        Token_Gateway01b=0;
                    end

                    % SLO and KPI attributes
                    p_av_Gateway01         =1;
                    d_mu_Gateway01         =0;
                    d_sigma2_Gateway01     =0;
                    p_f_Gateway01          =0;

                    % Check the availability
                    flag_operation_Gateway01(Simulation_Counter) =...
                        sum(rand >= cumsum([1- p_av_Gateway01,...
                        p_av_Gateway01]));
                    SimulationIsActive  = ...
                        flag_operation_Gateway01(Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Gateway01(Simulation_Counter)=...
                            d_mu_Gateway01+(d_sigma2_Gateway01*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T = max(T_Gateway01a,...
                            T_Gateway01b)+...
                            + T_Gateway01(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Activity02b=1;
                    else
                        flag_fault_Gateway01(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Gateway01,...
                            p_f_Gateway01]));
                    end
                end

            % Activity02 (ID:BE05)
                if ((SimulationIsActive==1)&&...
                        (Token_Activity02a==1)&&(Token_Activity02b==1))
                    Token_Activity02a=1;                % Simulation module
                    Token_Activity02b=0;

                    % SLO and KPI attributes
                    p_av_Activity02      =0.99;
                    d_mu_Activity02      =1;
                    d_sigma2_Activity02  =0.10;
                    p_f_Activity02       =0.10;

                    % Check the availability
                    flag_operation_Activity02(Simulation_Counter) =...
                        sum(rand >= cumsum([1- p_av_Activity02,...
                        p_av_Activity02]));
                    SimulationIsActive  = ...
                        flag_operation_Activity02(Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Activity02(Simulation_Counter)=...
                            d_mu_Activity02+...
                            (d_sigma2_Activity02*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T = max(T,T_Activity02a) + ...  % Simulation module
                            T_Activity02(Simulation_Counter);

                        % The Token passes to the
                        % next elements;
                        Token_Message01=1;              % Simulation module
                        Token_DataObject02=1;           % Simulation module
                    else
                        flag_fault_Activity02(Simulation_Counter) =...
                            sum(rand >= cumsum([1- p_f_Activity02,...
                            p_f_Activity02]));
                    end
                end

            % Message01 (ID:BE06)
                if ((SimulationIsActive==1)&&(Token_Message01==1))
                    Token_Message01=0;

                    % SLO and KPI attributes
                    p_av_Message01      =1;
                    d_mu_Message01      =0;
                    d_sigma2_Message01  =0;
                    p_f_Message01       =0;

                    % Check the availability
                    flag_operation_Message01(Simulation_Counter)...
                        = sum(rand >= cumsum([1- p_av_Message01,...
                        p_av_Message01]));
                    SimulationIsActive  = ...
                        flag_operation_Message01(Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message01(Simulation_Counter)=...
                            d_mu_Message01+(d_sigma2_Message01*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity04a = T + ...         % Simulation module
                            T_Message01(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Message02=1;
                    else
                        flag_fault_Message01(Simulation_Counter)...
                            = sum(rand >= ...
                            cumsum([1- p_f_Message01,...
                            p_f_Message01]));
                    end
                end

            % DataObject02 (ID:BE07)
                if ((SimulationIsActive==1)&&...
                        (Token_DataObject02==1))
                    Token_DataObject02=0;

                    % SLO and KPI attributes
                    p_av_DataObject02      =1;
                    d_mu_DataObject02      =0;
                    d_sigma2_DataObject02  =0;
                    p_f_DataObject02       =0;

                    % Check the availability
                    flag_operation_DataObject02...
                        (Simulation_Counter) = sum(rand >= ...
                        cumsum([1- p_av_DataObject02,...
                        p_av_DataObject02]));
                    SimulationIsActive  = ...
                        flag_operation_DataObject02...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_DataObject02(Simulation_Counter)=...
                            d_mu_DataObject02+...
                            (d_sigma2_DataObject02*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity04b = T + ...         % Simulation module
                            T_DataObject02(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Activity04a=1;            % Simulation module
                    else
                        flag_fault_DataObject02(Simulation_Counter)...
                            = sum(rand >= cumsum([1- ...
                            p_f_DataObject02,p_f_DataObject02]));
                    end
                end

            % Department B / Subdepartment A
            % Message02 (ID:BE08)
                if ((SimulationIsActive==1)&&(Token_Message02==1))
                    Token_Message02=0;

                    % SLO and KPI attributes
                    p_av_Message02      =1;
                    d_mu_Message02      =0;
                    d_sigma2_Message02  =0;
                    p_f_Message02       =0;

                    % Check the availability
                    flag_operation_Message02(Simulation_Counter) ...
                        = sum(rand >= cumsum([1- p_av_Message02,...
                        p_av_Message02]));
                    SimulationIsActive  = flag_operation_Message02...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message02(Simulation_Counter)=...
                            d_mu_Message02+(d_sigma2_Message02*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                   % Simulation module
                        T_Activity04a = T_Activity04a + ...
                            T_Message02(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Activity04b=1;
                    else
                        flag_fault_Message02(Simulation_Counter) =...
                            sum(rand >= cumsum([1- p_f_Message02,...
                            p_f_Message02]));
                    end
                end

            % Activity04 (ID:BE09)
                if ((SimulationIsActive==1)&&...        % Simulation module
                        (Token_Activity04a==1)&&(Token_Activity04b==1))
                    Token_Activity04a=0;
                    Token_Activity04b=0;

                    % SLO and KPI attributes
                    p_av_Activity04      =0.99;
                    d_mu_Activity04      =4.0;
                    d_sigma2_Activity04  =2.0;
                    p_f_Activity04       =0.10;

                    % Check the availability
                    flag_operation_Activity04(Simulation_Counter) ...
                        = sum(rand >= cumsum([1- p_av_Activity04,...
                        p_av_Activity04]));
                    SimulationIsActive  = flag_operation_Activity04...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Activity04(Simulation_Counter)=...
                            d_mu_Activity04+...
                            (d_sigma2_Activity04*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T = max(T_Activity04a,...       % Simulation module
                            T_Activity04b) + ...
                            T_Activity04(Simulation_Counter);

                        % The Token passes to the
                        % next elements;
                        Token_Message03=1;              % Simulation module
                        Token_DataObject03=1;           % Simulation module

                    else
                        flag_fault_Activity04(Simulation_Counter) ...
                            = sum(rand >= cumsum([1- p_f_Activity04,...
                            p_f_Activity04]));
                    end
                end

            % Message03 (ID:BE10)
                if ((SimulationIsActive==1)&&(Token_Message03==1))
                    Token_Message03=0;

                    % SLO and KPI attributes
                    p_av_Message03      =1;
                    d_mu_Message03      =0;
                    d_sigma2_Message03  =0;
                    p_f_Message03       =0;

                    % Check the availability
                    flag_operation_Message03(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Message03,...
                        p_av_Message03]));
                    SimulationIsActive  = flag_operation_Message03...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message03(Simulation_Counter)=...
                            d_mu_Message03+(d_sigma2_Message03*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = T + ...         % Simulation module
                            T_Message03(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Message04=1;
                    else
                        flag_fault_Message03(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Message03,...
                            p_f_Message03]));
                    end
                end

            % DataObject03 (ID:BE11)
                if ((SimulationIsActive==1)&&(Token_DataObject03==1))
                    Token_DataObject03=0;

                    % SLO and KPI attributes
                    p_av_DataObject03      =1;
                    d_mu_DataObject03      =0;
                    d_sigma2_DataObject03  =0;
                    p_f_DataObject03       =0;

                    % Check the availability
                    flag_operation_DataObject03(Simulation_Counter) ...
                        = sum(rand >= cumsum([1- p_av_DataObject03,...
                        p_av_DataObject03]));
                    SimulationIsActive  = ...
                        flag_operation_DataObject03...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_DataObject03(Simulation_Counter)=...
                            d_mu_DataObject03+...
                            (d_sigma2_DataObject03*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05b = T + ...         % Simulation module
                            T_DataObject03(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Activity05a=1;            % Simulation module
                    else
                        flag_fault_DataObject03(Simulation_Counter) ...
                            = sum(rand >= cumsum([1- ...
                            p_f_DataObject03,p_f_DataObject03]));
                    end
                end

            % Department A
            % Message04 (ID:BE12)
                if ((SimulationIsActive==1)&&(Token_Message04==1))
                    Token_Message04=0;

                    % SLO and KPI attributes
                    p_av_Message04      =1;
                    d_mu_Message04      =0;
                    d_sigma2_Message04  =0;
                    p_f_Message04       =0;

                    % Check the availability
                    flag_operation_Message04(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Message04,...
                        p_av_Message04]));
                    SimulationIsActive  = flag_operation_Message04...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message04(Simulation_Counter)=...
                            d_mu_Message04+(d_sigma2_Message04*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = ...             % Simulation module
                            T_Activity05a + ...
                            T_Message04(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Gateway02=1;
                    else
                        flag_fault_Message04(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Message04,...
                            p_f_Message04]));
                    end
                end

            % Gateway02 (ID:BE13)
                if ((SimulationIsActive==1)&&((Token_Gateway02==1)))
                    Token_Gateway02=0;

                    % SLO and KPI attributes
                    p_av_Gateway02         =1;
                    d_mu_Gateway02         =0;
                    d_sigma2_Gateway02     =0;
                    p_f_Gateway02          =0;
                    p_D1_Message05   =0.90;
                    p_D2_Activity03  =0.10;

                    % Check the availability
                    flag_operation_Gateway02(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Gateway02,...
                        p_av_Gateway02]));
                    SimulationIsActive  = ...
                        flag_operation_Gateway02(Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Gateway02(Simulation_Counter)=...
                            d_mu_Gateway02+(d_sigma2_Gateway02*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = ...             % Simulation module
                            T_Activity05a + ...
                            T_Gateway02(Simulation_Counter);

                        % Check the
                        % decision
                        % through
                        % a random number generator
                        % with the given appearance
                        % probabilities
                        decision_Gateway02(Simulation_Counter) = ....
                            sum(rand >= cumsum([0,p_D1_Message05,...
                            p_D2_Activity03]));

                        % The Token passes to the
                        % next element;
                        if (decision_Gateway02(Simulation_Counter)==1)
                            Token_Message05=1;
                            Token_Activity03=0;
                        elseif (decision_Gateway02...
                                (Simulation_Counter)==2)
                            Token_Message05=0;
                            Token_Activity03=1;
                            Counter_NOT_OK = ...        % Simulation module
                                Counter_NOT_OK+1;
                            T_Counter_NOT_OK...         % Simulation module
                                (Simulation_Counter) = Counter_NOT_OK;
                        end
                    else
                        flag_fault_Gateway02(Simulation_Counter) =...
                            sum(rand >= cumsum([1- p_f_Gateway02,...
                            p_f_Gateway02]));
                    end
                end

            % Activity03 (ID:BE14)
                if ((SimulationIsActive==1)&&(Token_Activity03==1))
                    Token_Activity03=0;

                    % SLO and KPI attributes
                    p_av_Activity03      =0.99;
                    d_mu_Activity03      =1;
                    d_sigma2_Activity03  =0.10;
                    p_f_Activity03       =0.04;

                    % Check the availability
                    flag_operation_Activity03(Simulation_Counter) =...
                        sum(rand >= cumsum([1- p_av_Activity03,...
                        p_av_Activity03]));
                    SimulationIsActive  = ...
                        flag_operation_Activity03(Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Activity03(Simulation_Counter)=...
                            d_mu_Activity03+...
                            (d_sigma2_Activity03*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = ...             % Simulation module
                            T_Activity05a + ...
                            T_Activity03(Simulation_Counter);
                        T_Gateway01b=T_Activity05a;     % Simulation module

                        % The Token passes to the
                        % next elements;
                        Token_Gateway01b=1;
                    else
                        flag_fault_Activity03(Simulation_Counter) ...
                            = sum(rand >= cumsum([1- p_f_Activity03,...
                            p_f_Activity03]));
                    end
                end

            % Message05 (ID:BE15)
                if ((SimulationIsActive==1)&&(Token_Message05==1))
                    Token_Message05=0;

                    % SLO and KPI attributes
                    p_av_Message05      =1;
                    d_mu_Message05      =0;
                    d_sigma2_Message05  =0;
                    p_f_Message05       =0;

                    % Check the availability
                    flag_operation_Message05(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Message05,...
                        p_av_Message05]));
                    SimulationIsActive  = flag_operation_Message05...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message05(Simulation_Counter)=...
                            d_mu_Message05+(d_sigma2_Message05*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = ...             % Simulation module
                            T_Activity05a + ...
                            T_Message05(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Message06=1;
                    else
                        flag_fault_Message05(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Message05,...
                            p_f_Message05]));
                    end
                end

            % Department B / Subdepartment B
            % Message06 (ID:BE16)
                if ((SimulationIsActive==1)&&(Token_Message06==1))
                    Token_Message06=0;

                    % SLO and KPI attributes
                    p_av_Message06      =1;
                    d_mu_Message06      =0;
                    d_sigma2_Message06  =0;
                    p_f_Message06       =0;

                    % Check the availability
                    flag_operation_Message06(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Message06,...
                        p_av_Message06]));
                    SimulationIsActive  = flag_operation_Message06...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Message06(Simulation_Counter)=...
                            d_mu_Message06+(d_sigma2_Message06*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T_Activity05a = ...             % Simulation module
                            T_Activity05a + ...
                            T_Message06(Simulation_Counter);

                        % The Token passes to the
                        % next element;
                        Token_Activity05b=1;            % Simulation module
                    else
                        flag_fault_Message06(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Message06,...
                            p_f_Message06]));
                    end
                end

            % Activity05 (ID:BE17)
                if ((SimulationIsActive==1)&&(Token_Activity05a==1)...
                        &&(Token_Activity05b==1))
                    Token_Activity05a=0;
                    Token_Activity05b=0;

                    % SLO and KPI attributes
                    p_av_Activity05      =0.99;
                    d_mu_Activity05      =1;
                    d_sigma2_Activity05  =0.20;
                    p_f_Activity05       =0.10;

                % SLO D
                    Counter_D_1= Counter_D_1 + 1;
                    T_Counter_D_1(Simulation_Counter)=Counter_D_1;

                    % Check the availability
                    flag_operation_Activity05(Simulation_Counter) = ...
                        sum(rand >= cumsum([1- p_av_Activity05,...
                        p_av_Activity05]));
                    SimulationIsActive  = flag_operation_Activity05...
                        (Simulation_Counter);

                    if (SimulationIsActive==1)
                        % Random Duration
                        T_Activity05(Simulation_Counter)=...
                            d_mu_Activity05+...
                            (d_sigma2_Activity05*randn);

                        % Duration of the BPMN IT
                        % business process until now.
                        T = max(T_Activity05a,...       % Simulation module
                            T_Activity05b) + ...
                            T_Activity05(Simulation_Counter);

                        % The Token passes to the
                        % next elements;
                        Token_Database01a=1;
                        Token_DataObject04=1;
                    else
                        flag_fault_Activity05(Simulation_Counter) = ...
                            sum(rand >= cumsum([1- p_f_Activity05,...
                            p_f_Activity05]));

                    %SLO D
                        % Counter_D_2
                        if flag_fault_Activity05(Simulation_Counter) == 1
                            Counter_D_2 = Counter_D_2+1;
                            T_Counter_D_2(Counter_D_1)=Counter_D_2;

                            % MathematicalOperator_D_1
                            MathematicalOperator_D_1=100* Counter_D_2/...
                                Counter_D_1;
                            T_MathematicalOperator_D_1(Counter_D_2)=...
                                MathematicalOperator_D_1;

                            % Flag_D_1
                            if (MathematicalOperator_D_1<=0.5)
                                Flag_D_1=1;
                            else
                                Flag_D_1=0;
                            end
                            T_Flag_D_1(Counter_D_2)=Flag_D_1;
                        end
                    end
                end
        end

    % DataObject04 (ID:BE18)
        if ((SimulationIsActive==1)&&(Token_DataObject04==1))
            Token_DataObject04=0;

            % SLO and KPI attributes
            p_av_DataObject04      =1;
            d_mu_DataObject04      =0;
            d_sigma2_DataObject04  =0;
            p_f_DataObject04       =0;

            % Check the availability
            flag_operation_DataObject04(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_DataObject04,...
                p_av_DataObject04]));
            SimulationIsActive  = flag_operation_DataObject04...
                (Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_DataObject04(Simulation_Counter)=...
                    d_mu_DataObject04+(d_sigma2_DataObject04*randn);

                % Duration of the BPMN IT
                % business process until now.
                T_Database01a = T +...                             % Simulation module
                    T_DataObject04(Simulation_Counter);

                % The Token passes to the
                % next elements;
                Token_Database01b=1;                    % Simulation module
            else
                flag_fault_DataObject04(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_DataObject04,...
                    p_f_DataObject04]));

            %SLO D
                % Counter_D_2
                if flag_fault_DataObject04(Simulation_Counter) == 1
                    Counter_D_2 = Counter_D_2+1;
                    T_Counter_D_2(Counter_D_1)=Counter_D_2;

                    % MathematicalOperator_D_1
                    MathematicalOperator_D_1=100* Counter_D_2/Counter_D_1;
                    T_MathematicalOperator_D_1(Counter_D_2)=...
                        MathematicalOperator_D_1;

                    % Flag_D_1
                    if (MathematicalOperator_D_1<=0.5)
                        Flag_D_1=1;
                    else
                        Flag_D_1=0;
                    end
                    T_Flag_D_1(Counter_D_2)=Flag_D_1;
                end
            end
        end

    % Database01 (ID:BE19)
        if ((SimulationIsActive==1)&&(Token_Database01a==1)&&...
                (Token_Database01b==1))
            Token_Database01a=0;
            Token_Database01b=0;

            % SLO and KPI attributes
            p_av_Database01      =0.993;
            d_mu_Database01      =0;
            d_sigma2_Database01  =0;
            p_f_Database01       =0.50;

            % Check the availability
            flag_operation_Database01(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_Database01,...
                p_av_Database01]));
            SimulationIsActive  = flag_operation_Database01...
                (Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_Database01(Simulation_Counter)=d_mu_Database01+...
                    (d_sigma2_Database01*randn);

                % Duration of the BPMN IT
                % business process until now.
           % Simulation module
                T = max(T_Database01a,T) + ...          % Simulation module
                    T_Database01(Simulation_Counter);

                % The Token passes to the
                % next elements;
                Token_EventEnd=1;

            else
                flag_fault_Database01(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_Database01,...
                    p_f_Database01]));

            %SLO D
                % Counter_D_2
                if flag_fault_Database01(Simulation_Counter) == 1
                    Counter_D_2 = Counter_D_2+1;
                    T_Counter_D_2(Counter_D_1)=Counter_D_2;

                    % MathematicalOperator_D_1
                    MathematicalOperator_D_1=100* Counter_D_2/Counter_D_1;
                    T_MathematicalOperator_D_1(Counter_D_2)=...
                        MathematicalOperator_D_1;

                    % Flag_D_1
                    if (MathematicalOperator_D_1<=0.5)
                        Flag_D_1=1;
                    else
                        Flag_D_1=0;
                    end
                    T_Flag_D_1(Counter_D_2)=Flag_D_1;
                end
            end
        end

    % EventEnd (ID:BE20)
        if ((SimulationIsActive==1)&&(Token_EventEnd==1))
            Token_EventEnd=0;

            % SLO and KPI attributes
            p_av_EventEnd      =1;
            d_mu_EventEnd      =0;
            d_sigma2_EventEnd  =0;
            p_f_EventEnd       =0;

            % Check the availability
            flag_operation_EventEnd(Simulation_Counter) = ...
                sum(rand >= cumsum([1- p_av_EventEnd,p_av_EventEnd]));
            SimulationIsActive  = flag_operation_EventEnd...
                (Simulation_Counter);

            if (SimulationIsActive==1)
                % Random Duration
                T_EventEnd(Simulation_Counter)=d_mu_EventEnd+...
                    (d_sigma2_EventEnd*randn);

                % Duration of the BPMN IT
                % business process until now.
            % Simulation module
                T = max(0, T + T_EventEnd(Simulation_Counter));

            % SLO A
                % Counter_A_2
                Counter_A_2= Counter_A_2 + 1;
                T_Counter_A_2(Counter_A_1)=Counter_A_2;

                % MathematicalOperator_A_1
                MathematicalOperator_A_1=100*Counter_A_2/ Counter_A_1;
                T_MathematicalOperator_A_1(Counter_A_2)=...
                    MathematicalOperator_A_1;

                % Flag_A_1
                if (MathematicalOperator_A_1>=95)
                    Flag_A_1=1;
                else
                    Flag_A_1=0;
                end
                T_Flag_A_1(Counter_A_2)=Flag_A_1;

            % SLO B
                % Counter_B_2
                Counter_B_2= Counter_B_2 + 1;
                T_Counter_B_2(Counter_B_1)=Counter_B_2;

                % Duration_B_1
                Duration_B_1 = T;
                T_Duration_B_1(Counter_B_2) = Duration_B_1;

            % SLO B1
                % Flag_B1_1
                if (Duration_B_1<=11)
                    Flag_B1_1=1;
                else
                    Flag_B1_1=0;
                end
                T_Flag_B1_1(Counter_B_2)= Flag_B1_1;

                % Counter_B1_1
                if (Flag_B1_1==1)
                    Counter_B1_1= Counter_B1_1+1;
                end
                T_Counter_B1_1(Counter_B_2)= Counter_B1_1;

                % MathematicalOperator_B1_1
                MathematicalOperator_B1_1=100* Counter_B1_1/Counter_B_2;
                T_MathematicalOperator_B1_1(Counter_B_2)=...
                    MathematicalOperator_B1_1;

                % Flag_B1_2
                if (MathematicalOperator_B1_1>=85)
                    Flag_B1_2=1;
                else
                    Flag_B1_2=0;
                end
                T_Flag_B1_2(Counter_B_2)=Flag_B1_2;

            % SLO B2
                % Flag_B2_1
                if (Duration_B_1<=23)
                    Flag_B2_1=1;
                else
                    Flag_B2_1=0;
                end
                T_Flag_B2_1(Counter_B_2)= Flag_B2_1;

                % Counter_B2_1
                if (Flag_B2_1==1)
                    Counter_B2_1= Counter_B2_1+1;
                end
                T_Counter_B2_1(Counter_B_2)= Counter_B2_1;

                % MathematicalOperator_B2_1
                MathematicalOperator_B2_1=100* Counter_B2_1/Counter_B_2;
                T_MathematicalOperator_B2_1(Counter_B_2)=...
                    MathematicalOperator_B2_1;

                % Flag_B2_2
                if (MathematicalOperator_B2_1>=99.5)
                    Flag_B2_2=1;
                else
                    Flag_B2_2=0;
                end
                T_Flag_B2_2(Counter_B_2)=Flag_B2_2;

            else
                flag_fault_EventEnd(Simulation_Counter) = ...
                    sum(rand >= cumsum([1- p_f_EventEnd,...
                    p_f_EventEnd]));
            end
        end
end
plot(T_MathematicalOperator_A_1)
print -dpng figure.png
toc;



%Paste the code in https://www.tutorialspoint.com/execute_matlab_online.php
% for further experimentation


%Use the code and cite the research article
%A. G. Lazaropoulos and H. C. Leligou, “SLAs, KPIs and BPMN Standard for the 
% Digital Transformation of the Enterprises’ IT Business Processes – The SLO 
% Cases of Service Desk Response Time and Fault Detection,” International Journal 
% of Synergy in Engineering and Technology, vol. 4, no. 2, pp. 1-36, Oct. 2023.

