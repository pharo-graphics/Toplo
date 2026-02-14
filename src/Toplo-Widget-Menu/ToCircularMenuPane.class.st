Class {
	#name : #ToCircularMenuPane,
	#superclass : #ToMenuPane,
	#category : #'Toplo-Widget-Menu-Pane'
}

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

	^ ToCircularMenuItemList new
]

{ #category : #skin }
ToCircularMenuPane >> newRawSkin [ 

	^ ToCircularMenuPaneSkin new
]
