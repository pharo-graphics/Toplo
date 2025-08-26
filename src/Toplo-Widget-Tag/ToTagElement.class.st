Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToColorableItemElement + TToRemovableItem + (TToRemovableNode - {#isRemovable})',
	#classTraits : 'TToColorableItemElement classTrait + TToRemovableItem classTrait + TToRemovableNode classTrait',
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #configuration }
ToTagElement >> applyConfiguration [ 

	super applyConfiguration.
	self removeRemoveButton.
	self isRemovable
		ifTrue: [ self addRemoveButton ].
	self requestNewSkin 
]

{ #category : #initialization }
ToTagElement >> initialize [ 

	super initialize.
	self takeFocusOnClick: false.
	removable := false
]

{ #category : #'t - checkable  - protocol' }
ToTagElement >> initializeAsCheckable [ 

	super initializeAsCheckable.
	self takeFocusOnClick: true
]

{ #category : #skin }
ToTagElement >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToCheckableTagSkin new ]
		  ifFalse: [ ToTagElementSkin new ]
]
