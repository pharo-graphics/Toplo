Class {
	#name : #ToEmptyPlaceholderLayer,
	#superclass : #ToPlaceholderLayer,
	#instVars : [
		'empty'
	],
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #accessing }
ToEmptyPlaceholderLayer >> empty [ 

	^ empty
]

{ #category : #initialization }
ToEmptyPlaceholderLayer >> initialize [

	super initialize.
	empty := ToEmpty box.
	self layout alignCenter.
	self preventMouseEvents.
	self addChild: empty
]
