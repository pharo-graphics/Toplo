Trait {
	#name : #TToClickableWidget,
	#category : #'Toplo-Core'
}

{ #category : #'t - click behavior' }
TToClickableWidget >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self when: BlClickEvent do: aBlock
]
