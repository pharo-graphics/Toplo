Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addedInSelectionDecoration: aSelectionDecoration [
]

{ #category : #'*Toplo' }
BlElement >> deselectedInInfiniteElement [
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> removedFromSelectionDecoration: aSelectionDecoration [
]

{ #category : #'*Toplo' }
BlElement >> selectedInInfiniteElement [
]

{ #category : #'*Toplo' }
BlElement >> selectedItemBackgroundColor [

	^ self theme item selectedColor
]

{ #category : #'*Toplo' }
BlElement >> selectedItemBlurredBackgroundColor [

	^ self selectedItemBackgroundColor muchLighter
]
