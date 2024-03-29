Class {
	#name : #ToListClassNodeExample,
	#superclass : #ToNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'label'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToListClassNodeExample >> forClassNameAssoc: aClassNameAssoc [

	| icon isel |
	isel := aClassNameAssoc key hasComment
		        ifTrue: [ #class ]
		        ifFalse: [ #uncommentedClass ].
	icon := Smalltalk ui icons iconNamed: isel.

	label := ToLabel new.
	label editorBuilder: [ :ed :lab | ed text foreground: Color black  ].
	label defaultRawSkin: ToLabelInListSkin new.
	label
		text: aClassNameAssoc value;
		beEditable.
	self
		stillPressedStartDelay: 400 milliSeconds;
		addEventHandler: (BlEventHandler
				 on: ToStillPressedLookEvent
				 do: [ :event |
					 event consumed: true.
					 event currentTarget label addEditorEvent: event ]);
		addEventHandler: (BlEventHandler
				 on: ToLabelTextReplacedEvent
				 do: [ self holder data value: label text asString ]).

	self addChild: (ToLabeledIcon new
			 label: label;
			 iconImage: icon;
			 interspace: 10;
			 hMatchParent)
]

{ #category : #initialization }
ToListClassNodeExample >> initialize [ 

	super initialize.
	" to have editable node on mouse still pressed one need toplo state generator "
	self initializeForToplo 
]

{ #category : #accessing }
ToListClassNodeExample >> label [

	^ label
]
