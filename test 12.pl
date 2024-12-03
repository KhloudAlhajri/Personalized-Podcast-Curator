/* 
Welcome to the Saudi Podcast Curator...

Helps you find the podcast that suits your desires...

% Knowledge base with podcasts

% Social
podcast('Algeria: A Kidnapped History', social, experiences, narration, long).
podcast('A mother''s solution', social, experiences, narration, short).
podcast('Has Man Been Able to Adapt to Evolution? | Dr. Faisal Hamid Al-Rifai', social, experiences, dialogue, long).
podcast('Mothers', social, experiences, dialogue, short).

podcast('Building Mental Strength | Paperless 112 | Dr. Khalid bin Hamad Al Jaber', social, narrative_style, narration, long).
podcast('How complicated is your life?', social, narrative_style, narration, short).
podcast('Freedom: Between Islam and Liberalism | Without Paper 120 | Dr. Nayef Bin Nahar', social, narrative_style, dialogue, long).
podcast('Why are the twenties the most dangerous stage? | Dr. Omar Al-Saadan', social, narrative_style, dialogue, short).

podcast('How to Gain Life Skills | Square Podcast', social, analysis, narration, long).
podcast('Al Hilal and Al Ittihad match analysis', social, analysis, narration, short).
podcast('The story of a Saudi coach in Europe', social, analysis, dialogue, long).
podcast('Discussion about player transfers in the Saudi League', social, analysis, dialogue, short).

% Educational
podcast('Independent Podcast: Lessons from Failure', educational, experiences, narration, long).
podcast('Lessons from failure', educational, experiences, narration, short).
podcast('Sheet: How Financial Apps Invest Your Money', educational, experiences, dialogue, long).
podcast('How to get an additional source of income', educational, experiences, dialogue, short).

podcast('How to Benefit from Artificial Intelligence in Your Day', educational, narrative_style, narration, long).
podcast('Charlie Manger', educational, narrative_style, narration, short).
podcast('It is impossible for artificial intelligence to defeat humans', educational, narrative_style, dialogue, long).
podcast('How to change your life and succeed in the most difficult circumstances', educational, narrative_style, dialogue, short).

podcast('How to Design Your Life and Live Satisfied', educational, analysis, narration, long).
podcast('Long term investment', educational, analysis, narration, short).
podcast('How to succeed in relationships with Yasser', educational, analysis, dialogue, long).
podcast('Investment Strategies: Concentration or Diversification?', educational, analysis, dialogue, short).

% Financial
podcast('How to profit from e-commerce?', financial, experiences, narration, long).
podcast('How to be creative in financial management and save your money?', financial, experiences, narration, short).
podcast('Sheet: How Financial Apps Invest Your Money', financial, experiences, dialogue, long).
podcast('How to get an additional source of income', financial, experiences, dialogue, short).

podcast('Coffee is the cause of your financial problems! With Reda Al-Eidaroos', financial, narrative_style, narration, long).
podcast('The best way to combat inflation', financial, narrative_style, narration, short).
podcast('How, when and where to invest?', financial, narrative_style, dialogue, long).
podcast('How do I succeed financially by investing?', financial, narrative_style, dialogue, short).

podcast('How to invest your salary to live rich with Salah Khashoggi', financial, analysis, narration, long).
podcast('Investment Strategies: Concentration or Diversification?', financial, analysis, narration, short).
podcast('How, when and where to invest?', financial, analysis, dialogue, long).
podcast('Financial market evaluation', financial, analysis, dialogue, short).

% Sports
podcast('From amateur to professional footballer with Hattan Bahebri', sports, experiences, narration, long).
podcast('Internal conflict in Al-Ahly leads to the dismissal of Yaisla', sports, experiences, narration, short).
podcast('Mohammed Al Sahlawi: I wish all the matches were between Al Hilal and Al Nasr', sports, experiences, dialogue, long).
podcast('The Sydney match is still in the memory', sports, experiences, dialogue, short).

podcast('Attracting stars and fair competition with the Minister of Sports', sports, narrative_style, narration, long).
podcast('Podcast with Saudi football legend.. Yasser Al-Qahtani', sports, narrative_style, narration, short).
podcast('Victory beats Al-Shabab and Al-Hilal continues to lead', sports, narrative_style, dialogue, long).
podcast('Podcast with Kuwaiti tennis commentator Adel Al Shatti', sports, narrative_style, dialogue, short).

podcast('What did the four clubs benefit from the investment fund?', sports, analysis, narration, long).
podcast('Who is a sports administrator?', sports, analysis, narration, short).
podcast('Discussion on sports strategies', sports, analysis, dialogue, long).
podcast('How to stick to the gym and workout easily', sports, analysis, dialogue, short).

% Suggestions of similar podcasts
similar_podcasts('Algeria: A Kidnapped History', ['Does marriage last without love?', 'Life in Management: Mutlaq Al-Muraished']).
similar_podcasts('A mother''s solution', ['Algeria: A Kidnapped History', 'How complicated is your life?']).
similar_podcasts('Investment Strategies: Concentration or Diversification?', ['How to invest your salary to live rich with Salah Khashoggi', 'How, when and where to invest?']).
similar_podcasts('It is impossible for artificial intelligence to defeat humans', ['Investment Strategies: Concentration or Diversification', 'Education']).
similar_podcasts('How to stick to the gym and workout easily', ['The story of a Saudi coach in Europe', 'From amateur to professional footballer with Hattan Bahebri']).


% Rule to find a matching podcast
find_podcast(Content, Attraction, Style, Length, Podcast, Similar) :-
    podcast(Podcast, Content, Attraction, Style, Length),
    (   similar_podcasts(Podcast, SimilarList) -> 
        Similar = SimilarList
    ;   Similar = ['No matching similar recommendations']
    ).

% Main program flow
rec_podcast :-
    write('------------------------------------------------- **** Saudi Podcast Curator **** -------------------------------------------------'), nl, nl,
    write('Welcome to the Saudi Podcast Curator...'), nl,
    write('Helps you find the podcast that suits your desires...'), nl, nl,
    write('Not: To exit the program at any time, write "exit".'), nl, nl,
    podcast_flow.

% Podcast flow
podcast_flow :-
    ask_content(Content),
    ask_exit(Content),
    ask_attraction(Attraction),
    ask_exit(Attraction),
    ask_style(Style),
    ask_exit(Style),
    ask_length(Length),
    ask_exit(Length),

    write('-----------------------------------------------------------------------------------------------------------------------------------'), nl,

    % Find and display the podcast recommendation
    ( find_podcast(Content, Attraction, Style, Length, Podcast, Similar)
    -> format('Recommended Podcast: ~w~n', [Podcast]),
       ( Similar = ['No matching similar recommendations'] ->
         write('No similar recommendations available.'), nl
       ; format('Similar Recommendations: ~w~n', [Similar])
       )
    ; write('No matching podcast found for the selected preferences.'), nl
    ),

    % Ask user if they want to continue
    ask_continue.

% Ask user to continue
ask_continue :-
    write('Do you want to continue? (yes/no): '), nl,
    read(Choice),
    (Choice == yes -> podcast_flow ; % Re-run the flow
     Choice == no -> write('OK, Bye'), nl ; % End program
     write('Invalid choice. Please try again.'), nl, ask_continue).

% Ask user for content type
ask_content(Content) :-
    repeat,
    write('1- What content interests you? (social, financial, educational, sports): '), nl,
    read(Content),
    (validate_input(Content, [social, financial, educational, sports, exit]) -> ! ;
     write('Invalid choice. Please try again.'), nl, fail).

% Ask user for attraction type
ask_attraction(Attraction) :-
    repeat,
    write('2- What attracts you to content? (experiences, analysis, narrative_style): '), nl,
    read(Attraction),
    (validate_input(Attraction, [experiences, analysis, narrative_style, exit]) -> ! ;
     write('Invalid choice. Please try again.'), nl, fail).

% Ask user for style
ask_style(Style) :-
    repeat,
    write('3- Do you prefer dialogue or narration? (dialogue, narration): '), nl,
    read(Style),
    (validate_input(Style, [dialogue, narration, exit]) -> ! ;
     write('Invalid choice. Please try again.'), nl, fail).

% Ask user for length
ask_length(Length) :-
    repeat,
    write('4- Do you prefer long or short content? (long, short): '), nl,
    read(Length),
    (validate_input(Length, [long, short, exit]) -> ! ;
     write('Invalid choice. Please try again.'), nl, fail).

% Check if the user wants to exit
ask_exit(Input) :-
    (Input == exit -> write('Thank you for using Saudi Podcast Curator'), nl, abort ; true).

% Validate input
validate_input(Input, Options) :-
    member(Input, Options).

% Start program automatically
:- rec_podcast.
