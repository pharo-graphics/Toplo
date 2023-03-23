Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> selectedItemBackgroundColor [

	^ self theme item selectedColor
]

{ #category : #'*Toplo' }
BlElement >> selectedItemBlurredBackgroundColor [

	^ self selectedItemBackgroundColor muchLighter
]
