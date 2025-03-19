Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToTagElement',
	#classTraits : 'TToTagElement classTrait',
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #configurating }
ToTagElement >> applyWidgetConfiguration [ 

	super applyWidgetConfiguration.
	removable
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ]
]

{ #category : #'t - labeled icon' }
ToTagElement >> icon: anElement [

	self iconDo: [ :ic | ic removeStamp: #'parent-tag' ].
	super icon: anElement.
	self iconDo: [ :ic | ic addStamp: #'parent-tag' withValue: self ]
]

{ #category : #initialization }
ToTagElement >> initialize [ 

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self takeFocusOnClick: false.
	removable := false
]

{ #category : #'t - checkable  - protocol' }
ToTagElement >> initializeAsCheckable [ 

	super initializeAsCheckable.
	self takeFocusOnClick: true
]

{ #category : #'t - labeled icon' }
ToTagElement >> label: anElement [

	self labelDo: [ :lab | lab removeStamp: #'parent-tag' ].
	super label: anElement.
	self labelDo: [ :lab | lab addStamp: #'parent-tag' withValue: self ]
]

{ #category : #skin }
ToTagElement >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToCheckableTagSkin new ]
		  ifFalse: [ ToTagSkin new ]
]

{ #category : #accessing }
ToTagElement >> requestNewConfigurationPass [ 

	super requestNewConfigurationPass
]
