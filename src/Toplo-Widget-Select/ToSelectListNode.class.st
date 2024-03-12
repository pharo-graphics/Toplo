Class {
	#name : #ToSelectListNode,
	#superclass : #ToNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSelectListNode >> initialize [ 

	super initialize.
	self initializeForToplo.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #accessing }
ToSelectListNode >> isGroup [

	^ self holder isGroup
]
