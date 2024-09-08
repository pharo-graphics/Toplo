"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox`
"
Class {
	#name : #ToListClassNodeExamplePart,
	#superclass : #ToListNode,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'instance creation' }
ToListClassNodeExamplePart >> forClassNameAssoc: aClassNameAssoc [

	| icon isel |
	isel := aClassNameAssoc key hasComment
		        ifTrue: [ #class ]
		        ifFalse: [ #uncommentedClass ].
	icon := Smalltalk ui icons iconNamed: isel.

	label := ToLabel new.
	label
		text: aClassNameAssoc value;
		beEditable.
	self
		stillPressedStartDelay: 400 milliSeconds;
		addEventHandler: (BlEventHandler
				 on: ToStillPressedSkinEvent
				 do: [ :event |
					 event consume.
					 event currentTarget label addEditorEvent: event ]);
		addEventHandler: (BlEventHandler
				 on: ToLabelTextReplacedEvent
				 do: [ self holder data value: label text asString ]).

	self addChild: (ToLabeledIcon new
			 label: label;
			 iconImage: icon;
			 startInterspace: 10;
			 hMatchParent)
]

{ #category : #accessing }
ToListClassNodeExamplePart >> label [

	^ label
]
