Class {
	#name : 'ToListClassNodeExample',
	#superclass : 'ToListNode',
	#instVars : [
		'label'
	],
	#category : 'Toplo-Examples',
	#package : 'Toplo-Examples'
}

{ #category : 'instance creation' }
ToListClassNodeExample >> forClassNameAssoc: aClassNameAssoc [

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
		stillPressedStartDelay: 400 milliSeconds;
		addEventHandler: (BlEventHandler
				 on: ToStillPressedLookEvent
				 do: [ :event |
					 event consumed: true.
					 event currentTarget addEditorEvent: event ]);
		whenTextReplacedDo: [ self holder data value: label text asString ].

	self addChild: (ToLabeledIcon new
			 label: label;
			 iconImage: icon;
			 interspace: 10;
			 hMatchParent)
]

{ #category : 'accessing' }
ToListClassNodeExample >> label [

	^ label
]
