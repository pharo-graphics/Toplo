"
A ToCheckLookTest is a test class for testing the behavior of ToCheckLook
"
Class {
	#name : #ToCheckLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToCheckLookTest >> testNoImage [

	" test with a look without any image "

	| w skin |
	w := ToCheckLookTestElement new.
	skin := ToWidgetSkin new.
	skin addLook: ToCheckLook new.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	w switchToSkinState: ToInitialState new.
	w switchToSkinState: ToDisabledState new.
	w switchToSkinState: ToFocusedState new.
	w switchToSkinState: ToHoveredState new.
	w switchToSkinState: ToOpenState new.
	w switchToSkinState: ToPressedState new.
	w switchToSkinState: ToSelectedState new.
	
]

{ #category : #tests }
ToCheckLookTest >> testWithImages [

	| w skin disabledImage checkedImage uncheckedImage indeterminateImage switch |
	w := ToCheckLookTestElement new.
	w initializeCheckable.
	w initializeDresser.
	w addDresser: ToCheckableButtonDresser new.
	skin := ToWidgetSkin new.
	
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
	switch := [ :e | e checked traceCr.
	          e isDisabled
		          ifTrue: [ disabledImage ]
		          ifFalse: [
			          e isChecked
				          ifTrue: [ checkedImage ]
				          ifFalse: [
					          e isUnchecked
						          ifTrue: [ uncheckedImage ]
						          ifFalse: [ indeterminateImage ] ] ] ].

	skin addLook: (ToCheckLook new
			 disabledStateValue: switch;
			 initialStateValue: switch;
			 hoveredStateValue: switch;
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w disable.
	self assert: w icon innerImage identicalTo: disabledImage.
	w enable.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w checked: true.
	self assert: w icon innerImage identicalTo: checkedImage.
	w checked: false.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w checked: nil.
	self assert: w icon innerImage identicalTo: indeterminateImage.




	
	
	

]
