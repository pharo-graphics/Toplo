Class {
	#name : #ToMenuWindow,
	#superclass : #ToMenuContainer,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #accessing }
ToMenuWindow >> isScrolling [ 

	^ self itemBar isScrolling
]

{ #category : #accessing }
ToMenuWindow >> isScrolling: aBoolean [

	self itemBar isScrolling: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
ToMenuWindow >> itemBar [ 

	^ self anchorElement itemBar
]
