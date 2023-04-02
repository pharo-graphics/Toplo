Class {
	#name : #ToLAFExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-Examples'
}

{ #category : #buttons }
ToLAFExamples class >> example_ButtonSkins [

	| space button1 button2 button3 button4 button5 |
	space := OBlSpace new.
	space root layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #primary.
	button1 labelText: 'Primary button'.
	
	button2 := ToButton skinType: #default.
	button2 labelText: 'Default button'.
	
	button3 := ToButton skinType: #dashed.
	button3 labelText: 'Dashed button'.
	
	button4 := ToButton skinType: #text.
	button4 labelText: 'Text button'.
	
	button5 := ToButton skinType: #link.
	button5 labelText: 'Link button'.
			
	space addChild: button1.
	space addChild: button2.
	space addChild: button3.
	space addChild: button4.
	space addChild: button5.
	space show.

	^space
]

{ #category : #buttons }
ToLAFExamples class >> example_ButtonSkins_Dark [

	| space |
	space := self example_ButtonSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #labels }
ToLAFExamples class >> example_LabelsSkins [

	| space label1 label2 label3 label4 label5 label6 |
	space := OBlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	
	label1 := ToLabel skinType: #default.
	label1 text: 'Toplo Theme (default)'.
	
	label2 := ToLabel skinType: #secondary.
	label2 text: 'Toplo Theme (secondary)'.
	
	label3 := ToLabel skinType: #success.
	label3 text: 'Toplo Theme (success)'.
	
	label4 := ToLabel skinType: #warning.
	label4 text: 'Toplo Theme (warning)'.
	
	label5 := ToLabel skinType: #danger.
	label5 text: 'Toplo Theme (danger)'.

	label6 := ToLabel skinType: #default.
	label6 text: 'Toplo Theme (disabled)'.
			
	space addChild: label1.
	space addChild: label2.
	space addChild: label3.
	space addChild: label4.
	space addChild: label5.
	space addChild: label6.
	
	space show.

	^space
]

{ #category : #labels }
ToLAFExamples class >> example_LabelsSkins_Dark [

	| space |
	space := self example_LabelsSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #buttons }
ToLAFExamples class >> example_MoreButtonSkins [

	| space |
	space := OBlSpace new.
	space root layout: (BlFlowLayout horizontal).
	
	1 to: 100 do:[ :i | | button1 button2 button3 button4 button5 |
		button1 := ToButton skinType: #primary.
		button1 labelText: 'Primary button ', i asString.
	
		button2 := ToButton skinType: #default.
		button2 labelText: 'Default button ', i asString.
	
		button3 := ToButton skinType: #dashed.
		button3 labelText: 'Dashed button ', i asString.
	
		button4 := ToButton skinType: #text.
		button4 labelText: 'Text button ', i asString.
	
		button5 := ToButton skinType: #link.
		button5 labelText: 'Link button ', i asString.
		
		space addChild: button1.
		space addChild: button2.
		space addChild: button3.
		space addChild: button4.
		space addChild: button5.
	].
	
	space show.
	^space
]

{ #category : #buttons }
ToLAFExamples class >> example_MoreButtonSkins_Dark [

	| space |
	space := self example_MoreButtonSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #labels }
ToLAFExamples class >> example_TitleLabelsSkins [

	| space label1 label2 label3 label4 label5 |
	space := OBlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	
	label1 := ToLabel skinType: #h1.
	label1 text: 'h1. Toplo Theme'.
	
	label2 := ToLabel skinType: #h2.
	label2 text: 'h2. Toplo Theme'.
	
	label3 := ToLabel skinType: #h3.
	label3 text: 'h3. Toplo Theme'.
	
	label4 := ToLabel skinType: #h4.
	label4 text: 'h4. Toplo Theme'.
	
	label5 := ToLabel skinType: #h5.
	label5 text: 'h5. Toplo Theme'.
			
	space addChild: label1.
	space addChild: label2.
	space addChild: label3.
	space addChild: label4.
	space addChild: label5.
	
	space show.

	^space
]

{ #category : #labels }
ToLAFExamples class >> example_TitleLabelsSkins_Dark [

	| space |
	space := self example_TitleLabelsSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #'see class side' }
ToLAFExamples >> seeClassSide [ 
]
