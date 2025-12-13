Class {
	#name : #ToTreeTableNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'event handling' }
ToTreeTableNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e hMatchParent ]
]
