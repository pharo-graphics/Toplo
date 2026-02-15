Class {
	#name : #ToCircularMenuPane,
	#superclass : #ToMenuPane,
	#traits : 'TToCircularMenuListUser',
	#classTraits : 'TToCircularMenuListUser classTrait',
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #configuration }
ToCircularMenuPane >> applyConfiguration [

	super applyConfiguration.
	self extent: (self radius * 2) asPoint
]

{ #category : #initialization }
ToCircularMenuPane >> initialize [

	super initialize.
	self allowAutoOpenManagement: false.
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
