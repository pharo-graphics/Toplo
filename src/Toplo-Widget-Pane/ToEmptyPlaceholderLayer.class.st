Class {
	#name : #ToEmptyPlaceholderLayer,
	#superclass : #ToPlaceholderLayer,
	#instVars : [
		'empty'
	],
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #'instance creation' }
ToEmptyPlaceholderLayer class >> withEmpty: anEmpty [

	^ self new
		  empty: anEmpty;
		  yourself
]

{ #category : #accessing }
ToEmptyPlaceholderLayer >> empty [ 

	^ empty
]

{ #category : #accessing }
ToEmptyPlaceholderLayer >> empty: anEmpty [

	empty ifNotNil: [ empty removeFromParent ].
	empty := anEmpty.
	empty ifNotNil: [ self addChild: empty ].
	self requestNewSkin
]

{ #category : #initialization }
ToEmptyPlaceholderLayer >> initialize [

	super initialize.
	self empty: ToEmpty box.
	self layout alignCenter.
	self preventMouseEvents.
]
