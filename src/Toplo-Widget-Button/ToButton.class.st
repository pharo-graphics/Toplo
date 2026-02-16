Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToTripletContainer + TToTripletElement + TToLabeledIcon + TToCheckable + TToOrientable',
	#classTraits : 'TToTripletContainer classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToCheckable classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Button-Clickable'
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
	self checkableState: nil.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> checkable: aBoolean [

	aBoolean
		ifTrue: [ self beCheckable ]
		ifFalse: [ self beNotCheckable ]
]

{ #category : #initialization }
ToButton >> initialize [ 

	super initialize.
	self initializeAsTripletElement
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToToggleButtonSkin new ]
		  ifFalse: [ ToButtonSkin new ]
]

{ #category : #configuration }
ToButton >> newToConfiguration [ 

	^ ToTripletElementConfiguration new
]
