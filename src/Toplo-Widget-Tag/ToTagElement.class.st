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
	self endElement: ic
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

{ #category : #skin }
ToTagElement >> installRawStyle [

	super installRawStyle.
	self isRemovable
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ]
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
