Class {
	#name : #ToElementTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Theme'
}

{ #category : #'radio button' }
ToElementTest >> testRadioButtonChangeTheme [

	| pane button1 button2 |
	pane := BlElement new.
	pane layout: (BlLinearLayout horizontal cellSpacing: 10).
	button1 := ToRadioButton skinType: #default.
	button2 := ToRadioButton skinType: #default.

	pane addChild: button1.
	pane addChild: button2.

	button1 check.

	self assert: button1 checked.
	self deny: button2 checked.

	pane toTheme: pane toTheme darkTheme.

	self assert: button1 checked.
	self deny: button2 checked
]
