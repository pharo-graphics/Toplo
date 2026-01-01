Extension { #name : #Object }

{ #category : #'*Toplo' }
Object >> asToLabelText [
	"Answer a BlText that can be used in a ToLabel and that represents the receiver."

	^ self asString
]

{ #category : #'*Toplo' }
Object class >> asTypeSelector [

	^ ToTypeSelector new type: self
]

{ #category : #'*Toplo' }
Object >> unwrappedDataItem [

	^ self
]
