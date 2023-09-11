"
A ToPropertyAdapterTest is a test class for testing the behavior of ToPropertyAdapter
"
Class {
	#name : #ToValueUpdaterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToValueUpdaterTest >> testCheckableIconImagePropertyUpdate1 [

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

	prop := ToExplicitPropertyDefinition new.
	prop writer: [ :e :v | v removeFromParent. e iconImage: v ].
	
	adapter := ToPropertyUpdater new
		  value: switch;
		  property: prop;
		  yourself.

	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.
	
	w checked: true.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.
	
	w checked: nil.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.
	
	w disable.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage.


]

{ #category : #tests }
ToValueUpdaterTest >> testCheckableIconImagePropertyUpdate2 [

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

	prop := ToExplicitPropertyDefinition new.
	prop writer: [ :e :v | v removeFromParent. e iconImage: v ].
	adapter := switch asPropertyUpdaterFor: prop.

	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.
	
	w checked: true.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.
	
	w checked: nil.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.
	
	w disable.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage.


]

{ #category : #tests }
ToValueUpdaterTest >> testCheckableIconImageUpdate [

	| w adapter disabledImage checkedImage uncheckedImage indeterminateImage switch |
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

	adapter := switch asElementUpdater.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.
	
	w checked: true.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.
	
	w checked: nil.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.
	
	w disable.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage.


]

{ #category : #tests }
ToValueUpdaterTest >> testElementUpdate1 [

	| w adapter |
	w := ToElement new.
	adapter := ToElementUpdater new valuable: [:e | e background: Color blue ].
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToValueUpdaterTest >> testElementUpdate2 [

	| w adapter |
	w := ToElement new.
	adapter := [:e | e background: Color blue ] asElementUpdater.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToValueUpdaterTest >> testPropertyUpdate [

	| w prop adapter |
	w := ToElement new.
	prop := ToExplicitPropertyDefinition new.
	prop writer: [ :e :v | e background: v ].
	adapter := Color blue asPropertyUpdaterFor: prop.
	self assert: adapter property equals: prop.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]
