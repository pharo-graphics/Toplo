Class {
	#name : #ToMenuWindow,
	#superclass : #ToMenuContainer,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #testing }
ToMenuWindow >> isScrollable [ 

	^ self itemBar isScrollable
]

{ #category : #accessing }
ToMenuWindow >> isScrollable: aBoolean [

	self itemBar isScrollable: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
ToMenuWindow >> itemBar [ 

	^ self anchorElement itemBar
]
