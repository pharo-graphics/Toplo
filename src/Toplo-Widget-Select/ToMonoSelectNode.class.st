Class {
	#name : #ToMonoSelectNode,
	#superclass : #ToSelectNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMonoSelectNode >> initialize [ 

	super initialize.
	middleContainer padding: (BlInsets right: 3).
	self padding: (BlInsets vertical: 4)
]
