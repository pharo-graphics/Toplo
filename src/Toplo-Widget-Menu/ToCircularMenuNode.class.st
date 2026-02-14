Class {
	#name : #ToCircularMenuNode,
	#superclass : #ToMenuItemNode,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #configuration }
ToCircularMenuNode >> applyConfiguration [ 

	super applyConfiguration.
	self fitContent
]

{ #category : #initialization }
ToCircularMenuNode >> initialize [

	super initialize.
	self fitContent
]
