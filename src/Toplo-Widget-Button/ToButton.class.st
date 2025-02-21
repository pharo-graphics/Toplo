Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToWithOrientableLayout + TToTripletElement + TToLabeledIcon + TToCheckable',
	#classTraits : 'TToWithOrientableLayout classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToCheckable classTrait',
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - labeled icon' }
ToButton class >> labelText: aTextOrString [

	^ self new
		  labelText: aTextOrString;
		  yourself
]

{ #category : #'t - labeled icon' }
ToButton class >> labelText: aTextOrString icon: anImage [

	^ self new
		  labelText: aTextOrString;
		  icon: anImage;
		  yourself
]

{ #category : #configuration }
ToButton >> beCheckable [

	self isCheckable ifTrue: [ ^ self ].
	self initializeAsCheckable.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> beNotCheckable [

	self isCheckable ifFalse: [ ^ self ].
	self releaseCheckable.
	self checkableData: nil.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> checkable: aBoolean [

	aBoolean
		ifTrue: [ self beCheckable ]
		ifFalse: [ self beNotCheckable ]
]

{ #category : #'t - labeled icon' }
ToButton >> icon: anElement [

	self icon = anElement ifTrue: [ ^ self ].
	self iconDo: [ :ic | ic removeStamp: #'parent-button' ].
	self startElement: anElement.
	self iconDo: [ :ic | ic addStamp: #'parent-button' withValue: self ]
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self initializeAsTripletElementOn: self
]

{ #category : #'t - labeled icon' }
ToButton >> label: anElement [

	self label = anElement ifTrue: [ ^ self ].
	self labelDo: [ :lab | lab removeStamp: #'parent-button' ].
	self middleElement: anElement.
	self labelDo: [ :lab | lab addStamp: #'parent-button' withValue: self ].

]

{ #category : #skin }
ToButton >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToToggleButtonSkin new ]
		  ifFalse: [ ToButtonSkin new ]
]
