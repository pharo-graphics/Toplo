Extension { #name : #ToElementExtension }

{ #category : #'*Toplo-Widget-Float' }
ToElementExtension >> floatOverlayIn: anElement [

	^ floatOverlay ifNil: [
			  floatOverlay := ToFloatOverlay new
				                  attachToParent: anElement;
				                  yourself ]
]
