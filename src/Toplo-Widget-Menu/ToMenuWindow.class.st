Class {
	#name : #ToMenuWindow,
	#superclass : #ToMenuContainer,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - item bar owner - accessing' }
ToMenuWindow >> itemBar [ 

	^ self anchorElement itemBar
]
