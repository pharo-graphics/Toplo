Class {
	#name : #ToCircularMenuNodeContainer,
	#superclass : #ToAnnulusSectorElement,
	#traits : 'TToNodeContainer + TToItemNodeContainer',
	#classTraits : 'TToNodeContainer classTrait + TToItemNodeContainer classTrait',
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #accessing }
ToCircularMenuNodeContainer >> holder: anHolder [

	super holder: anHolder.
	node := self nodeManager newNodeForHolder: self holder.
	node holder: anHolder
]

{ #category : #'instance creation' }
ToCircularMenuNodeContainer >> newRawSkin [ 

	^ ToCircularMenuNodeContainerSkin new
]

{ #category : #'t - node container - requirements' }
ToCircularMenuNodeContainer >> node [ 

	^ node
]
