Class {
	#name : #ToMultiSelectHeaderListElementConfiguration,
	#superclass : #ToBasicFiniteListElementConfiguration,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #hook }
ToMultiSelectHeaderListElementConfiguration >> defaultInnerElementClass [

	^ ToMultiSelectHeaderInnerListElement
]
