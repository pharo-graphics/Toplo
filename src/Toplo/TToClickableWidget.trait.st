Trait {
	#name : #TToClickableWidget,
	#traits : 'TToWidgetWithState',
	#classTraits : 'TToWidgetWithState classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization click behavior' }
TToClickableWidget >> initializeClickBehavior [

	self whenClickedDo: [ self switchToNextState ].
]

{ #category : #'t - click behavior' }
TToClickableWidget >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickLaunchAction do: aBlock
]
