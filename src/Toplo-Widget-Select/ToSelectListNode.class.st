Class {
	#name : #ToSelectListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-List'
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
