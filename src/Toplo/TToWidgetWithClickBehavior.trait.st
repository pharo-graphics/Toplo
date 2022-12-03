Trait {
	#name : #TToWidgetWithClickBehavior,
	#traits : 'TToWidgetWithState',
	#classTraits : 'TToWidgetWithState classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization click behavior' }
TToWidgetWithClickBehavior >> initializeClickBehavior [

	self whenClickedDo: [ self switchToNextState ].
]

{ #category : #'t - click behavior' }
TToWidgetWithClickBehavior >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickLaunchAction do: aBlock
]
