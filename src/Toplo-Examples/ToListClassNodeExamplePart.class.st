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
	self addEventHandler:
		(ToStillPressedEventHandler new startDelay: 800 milliSeconds).
	self addEventHandler: (BlEventHandler
			 on: ToStartStillPressedEvent
			 do: [ :event |
				 event consume.
				 event currentTarget label popupEditorEvent: event ]).
	label whenEditorOpenedDo: [ :editorEvent |
		editorEvent editorElement whenSaveRequestedDo: [ :request |
			request accepted: request currentTarget text isNotEmpty ].
		editorEvent editorElement whenSaveAcceptedDo: [ :acceptedEvent |
			editorEvent target text: acceptedEvent target text.
			self holder dataItem value: label text asString ] ].

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
