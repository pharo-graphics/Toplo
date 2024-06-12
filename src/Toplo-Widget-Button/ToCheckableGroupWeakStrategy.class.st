Class {
	#name : #ToCheckableGroupWeakStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupWeakStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [

	aCheckValue ifTrue: [ aGroup uncheckAllExcept: aCheckable ].
	^ true
]
