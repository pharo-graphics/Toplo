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
	self isRemovable
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ]
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
	self takeFocusOnClick: false
]

{ #category : #skin }
ToTagElement >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToCheckableTagSkin new ]
		  ifFalse: [ ToTagElementSkin new ]
]
