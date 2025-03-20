Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToRemovableItemElement + TToColorableItemElement',
	#classTraits : 'TToRemovableItemElement classTrait + TToColorableItemElement classTrait',
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - removable item element' }
ToTagElement >> addRemoveButton [

	| ic |
	self removeButton ifNotNil: [ ^ self ].
	ic := ToIconicRemoveButton new.
	ic id: #'tag-remove-button'.
	ic addStamp: #'parent-tag' withValue: self.
	self endElement: ic
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
		  ifFalse: [ ToTagElementSkin new ]
]

{ #category : #'t - removable item element' }
ToTagElement >> removeButton [

	^ self childWithId: #'tag-remove-button' ifNone: [  ] 
]

{ #category : #'t - removable item element' }
ToTagElement >> removeRemoveButton [

	self endElement: nil

]
