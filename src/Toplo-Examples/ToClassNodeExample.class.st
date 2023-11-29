Class {
	#name : #ToClassNodeExample,
	#superclass : #ToNode,
	#instVars : [
		'label'
	],
	#category : 'Toplo-Examples'
}

{ #category : #'instance creation' }
ToClassNodeExample >> forClassNameAssoc: aClassNameAssoc [

	| icon isel |
	isel := aClassNameAssoc key hasComment
		        ifTrue: [ #class ]
		        ifFalse: [ #uncommentedClass ].
	icon := Smalltalk ui icons iconNamed: isel.

	label := ToLabel new.
	label
		text: aClassNameAssoc value;
		margin: (BlInsets all: 1);
		padding: (BlInsets all: 1);
		beEditable;
		stillPressedStartDelay: 800 milliSeconds;
		when: ToStillPressedLookEvent do: [ :event |
			event consumed: true.
			event currentTarget addEditorEvent: event ];
		whenTextReplacedDo: [ self holder data value: label text asString ].


	self addChild: (ToLabeledIcon new
			 label: label;
			 iconImage: icon;
			 interspace: 10;
			 hMatchParent)
]

{ #category : #accessing }
ToClassNodeExample >> label [

	^ label
]
