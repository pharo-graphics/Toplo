Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #album }
ToSandBox class >> example_CodeEditorWithToClient [

"
The Client is a defined by user class. 
ToAlbumBasicClient implement typical Album user with a styler.
It is a kind of model but without any association from the widget to the client (no reference to the client is stored in widget).
It can be used and subclassed to support comment and code editing, workspace implementation...
All the different kind of Album using should use the available basic client class or subclass it for specific purpose.
Here an example of a client for a method.
"

	| text space client |
	text := self methodText asRopedText.
	client := ToAlbumViewModel new.
	client styler: (BlRBTextStyler new classOrMetaClass: self class).
	client text: text copy.
	client withSaveCapability.
	client onSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ].
	client onCancelRequestedDo: [ :cancelRequested | cancelRequested client text: text copy ].
	"client inspect."
	space := OBlSpace new.
	space root addChild: client onAlbum.
	space show.

]

{ #category : #album }
ToSandBox class >> example_EditorWithGhostText [

	| ghost |
	ghost := ('Here is a GhostText' , String cr , 'visible only if the text is empty') asRopedText.
	ghost foreground: Color lightGray.
	ghost fontSize: 24.

	(ToAlbumViewModel new
		 onSaveRequestedDo: [ :announcement | announcement client saveResult: true ];
		 withGhostText: ghost;
		 withLineNumbers;
		 withSaveCapability;
		 onSaveRequestedDo: [ :saveRequested | saveRequested client saveResult: true ];
		 withEditsFeedbackLayer) onAlbum openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel3 [

	| lab |
	lab := ToLabel new text: ('This is a bold label' asRopedText fontSize: 20; bold; foreground: Color gray; yourself).
	lab background: Color lightBlue.
	lab editable: true.
	lab alignCenter.
	lab border: (BlBorder paint: Color yellow width: 1).
	lab openInOBlSpace.

]

{ #category : #label }
ToSandBox class >> example_toLabel3_bis [

	| model widget |
	model := ToLabelViewModel new.
	model text: ('This is a bold label' asRopedText
			 fontSize: 20;
			 bold;
			 foreground: Color gray;
			 yourself).
	model widgetDo: [ :label | 
		label background: Color lightBlue.
		label alignCenter.
		label border: (BlBorder paint: Color yellow width: 1) ].
	model editable: true.
	(widget := model onLabel) openInOBlSpace	
]

{ #category : #label }
ToSandBox class >> example_toLabel4 [

	| lab1 lab2 lab3 root |
	root := BlElement new constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].

	root layout: BlLinearLayout vertical.
	lab1 := ToLabel new text: ('Editable centered monoline label' asRopedText fontSize: 18).
	lab1 editable: true.
	lab1 vFitContent.
	lab1 hMatchParent.
	lab1 alignCenter.
	lab1 border: (BlBorder paint: Color lightGray width: 1).
	root addChild: lab1.

	lab2 := ToLabel new text: (('Editable multiline label' , String cr , 'secondLine') asRopedText fontSize: 18).
	lab2 beMultiLine.
	lab2 vFitContent.
	lab2 hMatchParent.
	lab2 border: (BlBorder paint: Color lightGray width: 1).
	lab2 viewModel editable: true.

	root addChild: lab2.
	lab3 := ToLabel new text: ('Monoline label not editable' asRopedText fontSize: 18).
	lab3 border: (BlBorder paint: Color lightGray width: 1).
	lab3 vFitContent.
	lab3 hMatchParent.
	root addChild: lab3.
	root clipChildren: false.
	
	root openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel5 [

	| label root model |
	root := BlElement new constraintsDo: [ :c | 
		        c vertical fitContent.
		        c horizontal matchParent ].
	root layout: BlLinearLayout vertical.
	label := ToLabel new.
	model := ToLabelViewModel new.
	model text: ('' asRopedText fontSize: 24).
	model beMultiLine.
	model widgetDo: [ :widget | 
		widget vFitContent.
		widget hMatchParent.
		widget border: (BlBorder paint: Color red width: 1) ].
	model editable: true.
	label viewModel: model.
	root addChild: label.
	root openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabelWithStencil [

	| lab |
	lab := ToLabel new.
	lab innerElementStencil: [ :label | ToLabelMultiLineInnerElement new ].
	lab text: 'A multiline Label'.
	lab beEditable.
	lab openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabelWithStencil2 [

	| lab |
	lab := ToLabel new.
	lab innerElementStencil: [ :label | ToLabelInnerElementExample new ].
	lab beEditable.
	lab openInOBlSpace
]

{ #category : #label }
ToSandBox class >> example_toLabel_Multiline1 [

	| lab |
	lab := ToLabel new text: ('This is a Text', String cr, 'secondLine').
	lab beMultiLine.
	lab openInOBlSpace 
]

{ #category : #label }
ToSandBox class >> example_toLabel_Multiline2_Centered [

	| lab space |
	lab := ToLabel new text: (('This is a Centered editable label', String cr, 'size 20') asRopedText
			        fontName: AeFontManager defaultCodeFontFamilyName;
			        fontSize: 20).
	lab beMultiLine.
	lab matchParent.
	lab alignCenter.
	lab innerElement alignCenter.
	lab editable: true.
	space := lab openInOBlSpace
]

{ #category : #accessing }
ToSandBox class >> methodText [
	^ self  class sourceCodeAt: #example_CodeEditorWithToClient
]
