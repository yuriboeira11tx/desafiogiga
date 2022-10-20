import 'package:desafiogigaservices/models/user_model.dart';
import 'package:desafiogigaservices/widgets/tile_widget.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Usuário",
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  buildImage(),
                  buildName(),
                  TileWidget(
                    title: widget.user.gender! == "male"
                        ? "Masculino"
                        : "Feminino",
                    icon: widget.user.gender! == "male"
                        ? Icons.male
                        : Icons.female,
                  ),
                  TileWidget(
                    title: widget.user.email!,
                    icon: Icons.email,
                  ),
                  TileWidget(
                    title: "${widget.user.phone!}, ${widget.user.cell!}",
                    icon: Icons.phone,
                  ),
                  TileWidget(
                    title:
                        "${widget.user.id!.name!}: ${widget.user.id!.value!}",
                    icon: Icons.perm_identity,
                  ),
                  TileWidget(
                    title:
                        "${widget.user.dob!.age} - ${DateTime.parse(widget.user.dob!.date!).day}/${DateTime.parse(widget.user.dob!.date!).month}/${DateTime.parse(widget.user.dob!.date!).year}",
                    icon: Icons.calendar_month,
                  ),
                  TileWidget(
                    title:
                        "${widget.user.location!.city} - ${widget.user.location!.street!.name}, Nº${widget.user.location!.street!.number} - ${widget.user.location!.postcode}",
                    text:
                        "${widget.user.nat!} - ${widget.user.location!.state}",
                    icon: Icons.map,
                  ),
                  TileWidget(
                    title: widget.user.login!.password!,
                    icon: Icons.password,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGETS
  Widget buildImage() {
    final image = NetworkImage(widget.user.picture!.large!);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "${widget.user.name!.first!} ${widget.user.name!.last!}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            widget.user.login!.username!,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
