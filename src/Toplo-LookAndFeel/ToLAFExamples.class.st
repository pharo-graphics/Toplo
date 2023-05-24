Class {
	#name : #ToLAFExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-Examples'
}

{ #category : #buttons }
ToLAFExamples class >> example_ButtonSkins [

	| space button1 button2 button3 button4 button5 pane |
	space := OBlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
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
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #primary.
	button1 labelText: 'Primary button'.
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button2 := ToButton skinType: #default.
	button2 labelText: 'Default button'.
	button2 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button3 := ToButton skinType: #dashed.
	button3 labelText: 'Dashed button'.
	button3 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button4 := ToButton skinType: #text.
	button4 labelText: 'Text button'.
	button4 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button5 := ToButton skinType: #link.
	button5 labelText: 'Link button'.
	button5 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #primary.
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button2 := ToButton skinType: #default.
	button2 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button3 := ToButton skinType: #dashed.
	button3 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button4 := ToButton skinType: #text.
	button4 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button5 := ToButton skinType: #link.
	button5 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #dangerPrimary .
	button1 labelText: 'Danger primary'.
	button2 := ToButton skinType: #danger.
	button2 labelText: 'Danger default'.
	button3 := ToButton skinType: #dangerDashed.
	button3 labelText: 'Danger dashed'.
	button4 := ToButton skinType: #dangerText.
	button4 labelText: 'Danger text'.
	button5 := ToButton skinType: #dangerLink.
	button5 labelText: 'Danger link'.
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #dangerPrimary .
	button1 labelText: 'Danger primary'.
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button2 := ToButton skinType: #danger.
	button2 labelText: 'Danger default'.
	button2 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button3 := ToButton skinType: #dangerDashed.
	button3 labelText: 'Danger dashed'.
	button3 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button4 := ToButton skinType: #dangerText.
	button4 labelText: 'Danger text'.
	button4 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button5 := ToButton skinType: #dangerLink.
	button5 labelText: 'Danger link'.
	button5 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #dangerPrimary .
	button1 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button2 := ToButton skinType: #danger.
	button2 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button3 := ToButton skinType: #dangerDashed.
	button3 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button4 := ToButton skinType: #dangerText.
	button4 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
	button5 := ToButton skinType: #dangerLink.
	button5 icon: (ToImage new innerImage: (ToThemeIcons iconSearchOutlined16x16)).
			
	pane addChild: button1; addChild: button2; addChild: button3; addChild: button4; addChild: button5.
	space root addChild: pane.
	
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
			
	space root addChild: label1.
	space root addChild: label2.
	space root addChild: label3.
	space root addChild: label4.
	space root addChild: label5.
	space root addChild: label6.
	
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
		
		space root addChild: button1.
		space root addChild: button2.
		space root addChild: button3.
		space root addChild: button4.
		space root addChild: button5.
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

{ #category : #radio }
ToLAFExamples class >> example_RadioButtonSkins [

	| space button1 button2 pane |
	space := OBlSpace new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	
	pane := ToPane horizontal.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	button1 := ToRadioButton skinType: #default.
	button2 := ToRadioButton skinType: #default.
	pane addChild: button1.
	pane addChild: button2.
	
	space root addChild: pane.
	space show.
	
	button2 check.
	
	^space
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
			
	space root addChild: label1.
	space root addChild: label2.
	space root addChild: label3.
	space root addChild: label4.
	space root addChild: label5.
	
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

{ #category : #'themes and skins switching' }
ToLAFExamples class >> example_themeColorCustomization [

	| button1 space button2 button3 button4 button5 pane |
	space := self example_ButtonSkins.
	
	pane := ToPane horizontal.
	pane layout cellSpacing: 10.
	space root addChildFirst: pane.
	
	button1 := ToButton skinType: #primary.
	button1 labelText: 'Blue Theme'.
	button1 whenClickedDo: [ space toTheme: (space toTheme isDark ifTrue:[ ToTheme darkBlue ] ifFalse:[ ToTheme blue ]) ].
	pane addChild: button1.
	
	button2 := ToButton skinType: #primary.
	button2 labelText: 'Pink Theme'.
	button2 whenClickedDo: [ space toTheme: (space toTheme isDark ifTrue:[ ToTheme darkPink ] ifFalse:[ ToTheme pink ]) ].
	pane addChild: button2.
	
	button3 := ToButton skinType: #primary.
	button3 labelText: 'Green Theme'.
	button3 whenClickedDo: [ space toTheme: (space toTheme isDark ifTrue:[ ToTheme darkGreen ] ifFalse:[ ToTheme green ]) ].
	pane addChild: button3.
	
	button4 := ToButton skinType: #primary.
	button4 labelText: 'Random Theme'.
	button4 whenClickedDo: [ space toTheme: (space toTheme isDark ifTrue:[ ToTheme colorPrimaryDark: Color random ] ifFalse:[ ToTheme colorPrimary: Color random ]) ].
	pane addChild: button4.
	
	button5 := ToButton skinType: #primary.
	button5 labelText: 'Dark/Light Switch'.
	button5 whenClickedDo: [ space switchThemeDarkOrLight ].
	pane addChild: button5.
	
	space show
]

{ #category : #'themes and skins switching' }
ToLAFExamples class >> example_toButtonChangeThemeOnClickChangeSkinOnRightClick [

	| but space |
	space := OBlSpace new.
	
	but := ToButton skinType: #default.
	but labelText: 'Switch to the dark theme'.
	
	but whenClickedDo: [
		space switchThemeDarkOrLight. 
		space toTheme isDark
			ifTrue: [but labelText: 'Dark Theme'.  ]
			ifFalse: [but labelText: 'Light Theme' ] 
	].
			
	but when: BlMouseDownEvent do: [ :event |
		event secondaryButtonPressed ifTrue: [
			but skinType: (but skinType = #primary
					 ifTrue: [ #default ]
					 ifFalse: [ #primary ]) 
		].
	].
			
	space root addChild: but.
	space show
]

{ #category : #'see class side' }
ToLAFExamples >> seeClassSide [ 
]
