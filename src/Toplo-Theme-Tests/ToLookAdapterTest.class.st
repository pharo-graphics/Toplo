"
A ToPropertyAdapterTest is a test class for testing the behavior of ToPropertyAdapter
"
Class {
	#name : #ToLookAdapterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToLookAdapterTest >> testCheckableIconImageAdaption [

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

	adapter := switch asElementAdapter.
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
ToLookAdapterTest >> testCheckableIconImagePropertyAdaption1 [

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

	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | v removeFromParent. e iconImage: v ].
	
	adapter := ToPropertyAdapter new
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
ToLookAdapterTest >> testCheckableIconImagePropertyAdaption2 [

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

	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | v removeFromParent. e iconImage: v ].
	adapter := switch asPropertyAdapterFor: prop.

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
ToLookAdapterTest >> testElementAdaption1 [

	| w adapter |
	w := ToElement new.
	adapter := ToElementAdapter new valuable: [:e | e background: Color blue ].
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToLookAdapterTest >> testElementAdaption2 [

	| w adapter |
	w := ToElement new.
	adapter := [:e | e background: Color blue ] asElementAdapter.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToLookAdapterTest >> testPropertyAdaption [

	| w prop adapter |
	w := ToElement new.
	prop := ToPropertyDefinition new.
	prop writer: [ :e :v | e background: v ].
	adapter := Color blue asPropertyAdapterFor: prop.
	self assert: adapter property equals: prop.
	" whatever the LookEvent, the result should be the same "
	adapter announceLookEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]
