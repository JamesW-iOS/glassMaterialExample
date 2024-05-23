//
//  ImmersiveView.swift
//  glassMaterialExample
//
//  Created by James Warren on 23/5/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content, attachments in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                let attachment = attachments.entity(for: "foo")!
                let leftSphere = immersiveContentEntity.findEntity(named: "Sphere_Left")!
                attachment.position = [0, 0.2, 0]
                leftSphere.addChild(attachment)


                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                immersiveContentEntity.components.set(iblComponent)
                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))

                // Put skybox here.  See example in World project available at
                var skyboxMaterial = UnlitMaterial()
                let skyboxTexture = try! await TextureResource(named: "pano")
                skyboxMaterial.color = .init(texture: .init(skyboxTexture))
                let skyboxEntity = Entity()
                skyboxEntity.components.set(ModelComponent(mesh: .generateSphere(radius: 1000), materials: [skyboxMaterial]))
                skyboxEntity.scale *= .init(x: -1, y: 1, z: 1)
                content.add(skyboxEntity)
            }
        } update: { _, _ in
        } attachments: {
            Attachment(id: "foo") {
                Text("Hello")
                    .font(.extraLargeTitle)
                    .padding(48)
                    .glassBackgroundEffect()
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
}
