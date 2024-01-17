Class {
	#name : #ToMonoSelectHeaderNode,
	#superclass : #ToSelectHeaderNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMonoSelectHeaderNode >> initialize [ 

	super initialize.
	middleContainer layout: BlFrameLayout new.
	middleContainer padding: (BlInsets right: 3).
	self padding: (BlInsets vertical: 4)
]
