"
A ToPropertyAdapterTest is a test class for testing the behavior of ToPropertyAdapter
"
Class {
	#name : #ToLookEventSubscriptionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #tests }
ToLookEventSubscriptionTest >> testElementSubscription [

	| w adapter |
	w := ToElement new.
	adapter := ToElementSubscription new valuable: [:e | e background: Color blue ].
	adapter eventClass: ToInitialLookEvent.
	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testElementSubscriptionWithNonTrivialValuableConvertedASElementUpdater [

	| w subscr disabledImage checkedImage uncheckedImage indeterminateImage switch |
	w := ToCheckLookTestElement new.
	w initializeCheckable.
	w initializeDresser.
	w addDresser: ToCheckableButtonDresser new.

	disabledImage := BlElement new
		                 id: #disabled;
		                 yourself.
	checkedImage := BlElement new
		                id: #checked;
		                yourself.
	uncheckedImage := BlElement new
		                  id: #unchecked;
		                  yourself.
	indeterminateImage := BlElement new
		                      id: #indeterminate;
		                      yourself.
	switch := [ :e |
	          e isDisabled
		          ifTrue: [
			          disabledImage removeFromParent.
			          e iconImage: disabledImage ]
		          ifFalse: [
			          e isChecked
				          ifTrue: [
					          checkedImage removeFromParent.
					          e iconImage: checkedImage ]
				          ifFalse: [
					          e isUnchecked
						          ifTrue: [
							          uncheckedImage removeFromParent.
							          e iconImage: uncheckedImage ]
						          ifFalse: [
							          indeterminateImage removeFromParent.
							          e iconImage: indeterminateImage ] ] ] ].

	subscr := ToElementSubscription new
		          valuable: switch;
		          eventClass: ToInitialLookEvent;
		          yourself.
	" whatever the LookEvent, the result should be the same "
	subscr receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.
	
	w checked: true.
	" whatever the LookEvent, the result should be the same "
	subscr receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.
	
	w checked: nil.
	" whatever the LookEvent, the result should be the same "
	subscr receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.
	
	w disable.
	" whatever the LookEvent, the result should be the same "
	subscr receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage.


]

{ #category : #tests }
ToLookEventSubscriptionTest >> testElementSubscriptionWithValuableConvertedASElementUpdater [

	| w adapter |
	w := ToElement new.
	adapter := ToElementSubscription new valuable: [:e | e background: Color blue ].
	adapter eventClass: ToInitialLookEvent.
	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testPropertySubscription [

	| w prop subscription |
	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	subscription := ToPropertySubscription new
		  value: Color blue;
		  property: prop;
			eventClass: ToInitialLookEvent.
	self assert: subscription property equals: prop.
	" whatever the LookEvent, the result should be the same "
	subscription receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testPropertySubscriptionWithNonTrivialValuable [

	| w adapter disabledImage checkedImage uncheckedImage indeterminateImage switch prop |
	w := ToCheckLookTestElement new.
	w initializeCheckable.
	w initializeDresser.
	w addDresser: ToCheckableButtonDresser new.

	disabledImage := BlElement new
		                 id: #disabled;
		                 yourself.
	checkedImage := BlElement new
		                id: #checked;
		                yourself.
	uncheckedImage := BlElement new
		                  id: #unchecked;
		                  yourself.
	indeterminateImage := BlElement new
		                      id: #indeterminate;
		                      yourself.
	switch := [ :e |
	          e isDisabled
		          ifTrue: [
			          disabledImage ]
		          ifFalse: [
			          e isChecked
				          ifTrue: [
					          checkedImage ]
				          ifFalse: [
					          e isUnchecked
						          ifTrue: [
							          uncheckedImage ]
						          ifFalse: [
							          indeterminateImage ] ] ] ].

	prop := ToPseudoProperty new.
	prop writer: [ :e :v | v removeFromParent. e iconImage: v ].
	
	adapter := ToPropertySubscription new
		  value: switch;
		  property: prop;
		  yourself.

	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.
	
	w checked: true.
	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.
	
	w checked: nil.
	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.
	
	w disable.
	" whatever the LookEvent, the result should be the same "
	adapter receiveLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage.


]
