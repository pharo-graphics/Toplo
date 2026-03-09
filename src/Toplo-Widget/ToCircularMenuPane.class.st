Class {
	#name : #ToCircularMenuPane,
	#superclass : #ToMenuPane,
	#traits : 'TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait',
	#category : #'Toplo-Widget-Circular'
}

{ #category : #configuration }
ToCircularMenuPane >> applyConfiguration [

	super applyConfiguration.
	self extent: (self layoutRadius * 2) asPoint
]

{ #category : #initialization }
ToCircularMenuPane >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self itemList constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self matchParent
]

{ #category : #'t - item list owner - initializing' }
ToCircularMenuPane >> newItemList [ 

	^ ToCircularMenuList new
]

{ #category : #skin }
ToCircularMenuPane >> newRawSkin [ 

	^ ToCircularMenuPaneSkin new
]

{ #category : #'t - annulus sector layout user' }
ToCircularMenuPane >> stateHolder [

	^ self itemList 
]
