Class {
	#name : #ToCircularMenuNodeContainer,
	#superclass : #ToAnnulusSectorElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-Circular'
}

{ #category : #accessing }
ToCircularMenuNodeContainer >> holder: anHolder [

	super holder: anHolder.
	node := ToCircularMenuNode new.
	node holder: anHolder.
	self addChild: node
]

{ #category : #'instance creation' }
ToCircularMenuNodeContainer >> newRawSkin [ 

	^ ToCircularMenuNodeContainerSkin new
]

{ #category : #accessing }
ToCircularMenuNodeContainer >> node [ 

	^ node
]
