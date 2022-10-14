Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-examples'
}

{ #category : #label }
ToSandBox class >> example_toLabel1 [

	| lab |
	lab := ToLabel new text: 'This is a Text'.
	lab openInOBlSpace 
]

{ #category : #label }
ToSandBox class >> example_toLabel2 [

	| lab |
	lab := ToLabel new text: (('This is a Text') asRopedText fontName: AeFontManager defaultCodeFontFamilyName; fontSize: 20).
	lab openInOBlSpace 
]

{ #category : #label }
ToSandBox class >> example_toLabel3 [

	| lab |
	lab := ToLabel new text: ('This is a bold text' asRopedText fontSize: 20).
	lab alignCenterRight.
	lab textElement bold.
	lab hFitContent.
	lab background: Color lightBlue.
	lab textElement foreground: Color gray.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel4 [

	| lab |
	lab := ToLabel new text: ('This is a text' asRopedText fontSize: 14).
	lab border: (BlBorder paint: Color red width: 1).
	lab addEditor.
	lab openInOBlSpace.
	[  
	(Delay forSeconds: 10) wait.
	lab removeEditor] fork.
]
